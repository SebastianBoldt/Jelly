import UIKit

final class FadeAnimator: NSObject {
    private let presentationType : PresentationType
    private let presentation : FadePresentation
    private var currentPropertyAnimator: UIViewPropertyAnimator?

    init(presentationType: PresentationType, presentation: FadePresentation) {
        self.presentationType = presentationType
        self.presentation = presentation
        super.init()
    }
}

extension FadeAnimator : UIViewControllerAnimatedTransitioning {
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return currentPropertyAnimator ?? createPropertyAnimator(using: transitionContext)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentation.presentationTiming.duration.timeInterval
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let propertyAnimator = createPropertyAnimator(using: transitionContext)
        currentPropertyAnimator = propertyAnimator
        propertyAnimator.startAnimation()
    }
    
    private func createPropertyAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewPropertyAnimator {
        let key = getPresentedViewControllerKeyForPresentationType(type: self.presentationType)
        let isPresentation = key == .to
        let controllerToAnimate = transitionContext.viewController(forKey: key)!
        
        // If we animate to the ViewController we need to add the View to the ContainerView
        if isPresentation {
            transitionContext.containerView.addSubview(controllerToAnimate.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controllerToAnimate) // Frame the ViewController
        
        let finalAlpha = isPresentation ? 1.0 : 0.0
        let initialAlpha = isPresentation ? 0.0 : 1.0
        
        let animationDuration = transitionDuration(using: transitionContext)
        controllerToAnimate.view.frame = presentedFrame
        controllerToAnimate.view.alpha = CGFloat(initialAlpha)
        
        let timing = presentation.presentationTiming
        let animationCurve = isPresentation ? timing.presentationCurve : timing.dismissCurve
        let timingCurveProvider = UICubicTimingParameters(animationCurve: animationCurve)
        let propertyAnimator = UIViewPropertyAnimator(duration: animationDuration, timingParameters: timingCurveProvider)
        
        propertyAnimator.addAnimations {
            controllerToAnimate.view.alpha = CGFloat(finalAlpha)
        }
        
        propertyAnimator.addCompletion { animatedPosition in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        return propertyAnimator
    }
}
