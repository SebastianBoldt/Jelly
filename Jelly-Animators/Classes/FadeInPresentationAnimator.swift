//
//  SlideInPresentationAnimator.swift
//  Created by Sebastian Boldt on 18.11.16.

import Foundation

final class FadeInPresentationAnimator: NSObject {
    
    let presentationType : JellyConstants.PresentationType
    let presentation : JellyPresentation
    
    init(presentationType: JellyConstants.PresentationType, presentation: JellyPresentation) {
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
        
        let key: UITransitionContextViewControllerKey = getViewControllerKeyForPresentationType(type: self.presentationType)
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
        
        var jellyness = Jelly()
        
        UIView.animate(withDuration: presentation.duration.rawValue,
                       delay: 0.0,
                       options: presentation.curve.getAnimationOptionForJellyCurve(),
                       animations: {
                        controllerToAnimate.view.alpha = CGFloat(finalAlpha)
        }, completion:{ finished in
            transitionContext.completeTransition(finished)
        })
        
    }
    
    private func getViewControllerKeyForPresentationType(type: JellyConstants.PresentationType) -> UITransitionContextViewControllerKey {
        switch type {
        case .show:
            return UITransitionContextViewControllerKey.to
        case .dismiss:
            return UITransitionContextViewControllerKey.from
        }
    }
}
