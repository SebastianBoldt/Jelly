import UIKit

final class SlideAnimator: NSObject {
    private let presentationType : PresentationType
    private let presentation : SlidePresentation
    private var currentPropertyAnimator: UIViewPropertyAnimator?

    init(presentationType: PresentationType, presentation: SlidePresentation) {
        self.presentationType = presentationType
        self.presentation = presentation
        super.init()
    }
}

extension SlideAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentation.presentationTiming.duration.timeInterval
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let propertyAnimator = createPropertyAnimator(using: transitionContext)
        currentPropertyAnimator = propertyAnimator
        propertyAnimator.startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return currentPropertyAnimator ?? createPropertyAnimator(using: transitionContext)
    }
    
    func createPropertyAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewPropertyAnimator{
        let presentedKey = getPresentedViewControllerKeyForPresentationType(type: self.presentationType)
        let underlyingKey = getUnderlyingViewControllerKeyForPresentationType(type: self.presentationType)
        
        let isPresentation = (presentedKey == .to) // Are we presenting or dismissing
        let presentedViewController = transitionContext.viewController(forKey: presentedKey)! // ViewController that will be presented and removed on dismissal
        let underlyingViewController = transitionContext.viewController(forKey: underlyingKey)! // Viewcontroller we present from and we need to animate in on dismissal
        
        // If we animate to the ViewController we need to add the View to the ContainerView
        if isPresentation {
            transitionContext.containerView.addSubview(presentedViewController.view)
        }
        
        // Frames for pushed ViewController
        let presentedFrameForPresented = transitionContext.finalFrame(for: presentedViewController) // Frame the ViewController will have after animation completes
        let dismissedFrameForPresented = calculateDismissedFrame(from: presentedFrameForPresented, usingDirection: presentation.showDirection, andContext: transitionContext) // Frame the ViewController will have when he is dismissed
        
        var presentedFrameForUnderlying = transitionContext.containerView.frame
        
        switch self.presentation.showDirection {
            case .left:
                presentedFrameForUnderlying.origin.x = presentedFrameForPresented.origin.x + (presentedFrameForPresented.size.width * presentation.parallax)
            case .right:
                presentedFrameForUnderlying.origin.x = presentedFrameForUnderlying.origin.x - (presentedFrameForPresented.size.width * presentation.parallax)
            case .top:
                presentedFrameForUnderlying.origin.y = presentedFrameForPresented.origin.y + (presentedFrameForPresented.size.height * presentation.parallax)
            case .bottom:
                presentedFrameForUnderlying.origin.y = presentedFrameForUnderlying.origin.y - (presentedFrameForPresented.size.height * presentation.parallax)
        }
        
        let dismissedFrameForUnderLying = transitionContext.containerView.frame
        
        // Depending on which kind of presentation we are currently doing we swift frames
        let initialFrameForPresented = isPresentation ? dismissedFrameForPresented : presentedFrameForPresented
        let finalFrameFoPresented = isPresentation ? presentedFrameForPresented : dismissedFrameForPresented
        
        let initialFrameForUnderlying = isPresentation ? dismissedFrameForUnderLying : presentedFrameForUnderlying
        let finalFrameForUnderlying = isPresentation ? presentedFrameForUnderlying : dismissedFrameForUnderLying
        
        let animationDuration = transitionDuration(using: transitionContext)
        presentedViewController.view.frame = initialFrameForPresented
        underlyingViewController.view.frame = initialFrameForUnderlying
        
        let animationCurve = isPresentation ? presentation.presentationTiming.presentationCurve : presentation.presentationTiming.presentationCurve
        let direction = presentation.showDirection
        let velocityVector = direction == .bottom || direction == .top ? CGVector(dx: 0, dy: presentation.spring.velocity) : CGVector(dx: presentation.spring.velocity, dy: 0)
        let springParameters = UISpringTimingParameters(dampingRatio: presentation.spring.damping, initialVelocity: velocityVector)
        let cubicParameters = UICubicTimingParameters(animationCurve: animationCurve)
        let timingCurveProvider = CombinedTimingCurveProvider(springParameters: springParameters, cubicParameters: cubicParameters)
        
        let propertyAnimator = UIViewPropertyAnimator(duration: animationDuration, timingParameters: timingCurveProvider)
        
        propertyAnimator.addAnimations {
            presentedViewController.view.frame = finalFrameFoPresented
            underlyingViewController.view.frame = finalFrameForUnderlying
        }
        
        propertyAnimator.addCompletion { animatedPosition in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        return propertyAnimator
    }
}

extension SlideAnimator {
    /// Return dismissed frame depending on provides direction
    ///
    /// - Parameters:
    ///   - presentedFrame: frame the viewController will have if he is fully presented
    ///   - transitionContext: nothing to say here
    /// - Returns: the frame the view should have afer dismissing it
    private func calculateDismissedFrame(from presentedFrame: CGRect,
                                         usingDirection direction: Direction,
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

