import Foundation

final class SlideInPresentationAnimator: NSObject {
    let presentationType : Constants.PresentationType
    let presentation : SlideInPresentation
    
    init(presentationType: Constants.PresentationType, presentation: SlideInPresentation) {
        self.presentationType = presentationType
        self.presentation = presentation
        super.init()
    }
}

extension SlideInPresentationAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentation.duration.rawValue
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = getPresentedViewControllerKeyForPresentationType(type: self.presentationType)
        let isPresentation = key == .to
        let controllerToAnimate = transitionContext.viewController(forKey: key)!
        
        // If we animate to the ViewController we need to add the View to the ContainerView
        if isPresentation {
            transitionContext.containerView.addSubview(controllerToAnimate.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controllerToAnimate) // Frame the ViewController will have after animation completes
        let direction = self.presentationType == .show ? presentation.directionShow : presentation.directionDismiss
        let dismissedFrame = calculateDismissedFrame(from: presentedFrame, usingDirection: direction, andContext: transitionContext) // Frame the ViewController will have when he is dismissed
        print(dismissedFrame)
        
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        
        let animationDuration = transitionDuration(using: transitionContext)
        controllerToAnimate.view.frame = initialFrame
        
        let animationCurve = isPresentation ? presentation.presentationCurve : presentation.dismissCurve
        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: self.presentation.spring.damping,
                       initialSpringVelocity: self.presentation.spring.velocity,
                       options: animationCurve.animationOptions,
        animations: {
            controllerToAnimate.view.frame = finalFrame
        }, completion:{ finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    
    /// Return dismissed frame depending on provides direction
    ///
    /// - Parameters:
    ///   - presentedFrame: frame the viewController will have if he is fully presented
    ///   - transitionContext: nothing to say here
    /// - Returns: the frame the view should have afer dismissing it
    private func calculateDismissedFrame(from presentedFrame: CGRect, usingDirection direction: Constants.Direction , andContext transitionContext: UIViewControllerContextTransitioning) -> CGRect {
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
