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
        
        let key: UITransitionContextViewControllerKey = getViewControllerKeyForPresentationType(type: self.presentationType)
        let isPresentation = key == .to
        let controllerToAnimate = transitionContext.viewController(forKey: key)!
        
        // If we animate to the ViewController we need to add the View to the ContainerView
        if isPresentation {
            transitionContext.containerView.addSubview(controllerToAnimate.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controllerToAnimate) // Frame the ViewController will have after animation completes
        var dismissedFrame = calculateDismissedFrame(from: presentedFrame, andContext: transitionContext) // Frame the ViewController will have when he is dismissed
        print(dismissedFrame)
        
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        
        let animationDuration = transitionDuration(using: transitionContext)
        controllerToAnimate.view.frame = initialFrame
        
        var jellyness = Jelly()
        
        if isPresentation {
            jellyness = Helper.convertJellyness(jellyness: presentation.jellyness)
        }
        
        UIView.animate(withDuration: presentation.duration.rawValue,
                       delay: 0.0,
                       usingSpringWithDamping: jellyness.damping,
                       initialSpringVelocity: jellyness.velocity,
                       options: presentation.curve.getAnimationOptionForJellyCurve(),
        animations: {
            controllerToAnimate.view.frame = finalFrame
        }, completion:{ finished in
            transitionContext.completeTransition(finished)
        })
        
    }
    
    private func calculateDismissedFrame(from presentedFrame: CGRect, andContext transitionContext: UIViewControllerContextTransitioning) -> CGRect {
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
    
    private func getViewControllerKeyForPresentationType(type: JellyConstants.PresentationType) -> UITransitionContextViewControllerKey {
        switch type {
        case .show:
            return UITransitionContextViewControllerKey.to
        case .dismiss:
            return UITransitionContextViewControllerKey.from
        }
    }
}
