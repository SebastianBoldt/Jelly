//
//  SlideInPresentationAnimator.swift
//  Created by Sebastian Boldt on 18.11.16.

import Foundation

final class SlideInPresentationAnimator: NSObject {
    
    let direction: JellyConstants.Direction
    let presentationType : JellyConstants.PresentationType
    let presentation : JellyPresentation
    
    init(direction: JellyConstants.Direction, presentationType: JellyConstants.PresentationType, presentation: JellyPresentation) {
        self.direction = direction
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
        
        let key: UITransitionContextViewControllerKey
        switch presentationType {
        case .show:
            key = UITransitionContextViewControllerKey.to
        case .dismiss:
              key = UITransitionContextViewControllerKey.from
        }
        
        let controller = transitionContext.viewController(forKey: key)!
        
        if key == .to {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
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
        
        let initialFrame = key == .to ? dismissedFrame : presentedFrame
        let finalFrame = key == .to ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        
        var jellyness = Jelly(damping: 1.0, velocity: 1.0)
        
        if key == .to {
            jellyness = Helper.convertJellyness(jellyness: presentation.jellyness)
        }
        
        UIView.animate(withDuration: presentation.duration.rawValue,
                       delay: 0.0,
                       usingSpringWithDamping: jellyness.damping,
                       initialSpringVelocity: jellyness.velocity,
                       options: presentation.curve.getAnimationOptionForJellyCurve(),
        animations: {
            controller.view.frame = finalFrame
        }, completion:{ finished in
            transitionContext.completeTransition(finished)
        })
        
    }
}
