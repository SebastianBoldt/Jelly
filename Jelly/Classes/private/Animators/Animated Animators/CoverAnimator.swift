import Foundation

final class CoverAnimator: NSObject {
    private let presentationType : PresentationType
    private let presentation : CoverPresentation
    private var screenshot: UIView?
    
    init(presentationType: PresentationType, presentation: CoverPresentation) {
        self.presentationType = presentationType
        self.presentation = presentation
        super.init()
    }
}

extension CoverAnimator : UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let propertyAnimator = createPropertyAnimator(using: transitionContext)
        propertyAnimator.startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return createPropertyAnimator(using: transitionContext)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentation.presentationTiming.duration.timeInterval
    }
    
    func createPropertyAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewPropertyAnimator {
        let key = getPresentedViewControllerKeyForPresentationType(type: self.presentationType)
        let isPresentation = key == .to
        let controllerToAnimate = transitionContext.viewController(forKey: key)!
        
        // If we animate to the ViewController we need to add the View to the ContainerView
        if isPresentation {
            transitionContext.containerView.addSubview(controllerToAnimate.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controllerToAnimate) // Frame the ViewController will have after animation completes
        let direction = self.presentationType == .show ? presentation.showDirection : presentation.dismissDirection
        let dismissedFrame = calculateDismissedFrame(from: presentedFrame, usingDirection: direction, andContext: transitionContext) // Frame the ViewController will have when he is dismissed
        
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        controllerToAnimate.view.frame = initialFrame
        
        let timing = presentation.presentationTiming
        let animationCurve = isPresentation ? timing.presentationCurve : timing.dismissCurve
        
        let velocityVector = direction == .bottom || direction == .top ? CGVector(dx: 0, dy: presentation.spring.velocity) : CGVector(dx: presentation.spring.velocity, dy: 0)
        let springParameters = UISpringTimingParameters(dampingRatio: presentation.spring.damping, initialVelocity: velocityVector)
        let cubicParameters = UICubicTimingParameters(animationCurve: animationCurve)
        let timingCurveProvider = CombinedTimingCurveProvider(springParameters: springParameters, cubicParameters: cubicParameters)
        
        let propertyAnimator = UIViewPropertyAnimator(duration: animationDuration, timingParameters: timingCurveProvider)

        propertyAnimator.addAnimations {
            if isPresentation {
                if let presentingViewController = transitionContext.viewController(forKey: .from) {
                    presentingViewController.view.transform = CGAffineTransform(scaleX: self.presentation.depthScale,
                                                                                y: self.presentation.depthScale)
                    if UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20 {
                        let maskLayer = CAShapeLayer()
                        maskLayer.path = UIBezierPath(roundedRect: presentingViewController.view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 38.5, height: 38.5)).cgPath
                        presentingViewController.view.layer.mask = maskLayer
                    }
                }
            } else {
                transitionContext.viewController(forKey: .to)!.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
            controllerToAnimate.view.frame = finalFrame
        }
        
        propertyAnimator.addCompletion { animatedPosition in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        return propertyAnimator
    }
}

extension CoverAnimator {
    /// Return dismissed frame depending on provides direction
    ///
    /// - Parameters:
    ///   - presentedFrame: frame the viewController will have if he is fully presented
    ///   - transitionContext: nothing to say here
    /// - Returns: the frame the view should have afer dismissing it
    private func calculateDismissedFrame(from presentedFrame: CGRect,
                                         usingDirection direction: Direction ,
                                         andContext transitionContext: UIViewControllerContextTransitioning) -> CGRect {
        var dismissedFrame: CGRect = presentedFrame
        switch direction {
            case .left:
                dismissedFrame.origin.x = -presentedFrame.width
            case .right:
                dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
            case .top:
                dismissedFrame.origin.y = -presentedFrame.height
            case .bottom:
                dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
        }
        return dismissedFrame
    }
}
