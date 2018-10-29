import Foundation

final class FadeInPresentationAnimator: NSObject {
    
    let presentationType : Constants.PresentationType
    let presentation : FadeInPresentation
    
    init(presentationType: Constants.PresentationType, presentation: FadeInPresentation) {
        self.presentationType = presentationType
        self.presentation = presentation
        super.init()
    }
}

extension FadeInPresentationAnimator : UIViewControllerAnimatedTransitioning {
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
        
        let presentedFrame = transitionContext.finalFrame(for: controllerToAnimate) // Frame the ViewController
        
        let finalAlpha = isPresentation ? 1.0 : 0.0
        let initialAlpha = isPresentation ? 0.0 : 1.0
        
        let animationDuration = transitionDuration(using: transitionContext)
        controllerToAnimate.view.frame = presentedFrame
        controllerToAnimate.view.alpha = CGFloat(initialAlpha)
                
        let animationCurve = isPresentation ? presentation.presentationCurve : presentation.dismissCurve

        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       options: animationCurve.animationOptions,
                       animations: {
                        controllerToAnimate.view.alpha = CGFloat(finalAlpha)
        }, completion:{ finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
    }
}
