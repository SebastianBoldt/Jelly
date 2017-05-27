//
//  SlideInPresentationAnimator.swift
//  Created by Sebastian Boldt on 18.11.16.

import Foundation

final class JellySlideInPresentationAnimator: NSObject {
    
    let direction: JellyConstants.Direction
    let presentationType : JellyConstants.PresentationType
    let presentation : JellySlideInPresentation
    
    init(direction: JellyConstants.Direction, presentationType: JellyConstants.PresentationType, presentation: JellySlideInPresentation) {
        self.direction = direction
        self.presentationType = presentationType
        self.presentation = presentation
        super.init()
    }
    
}

extension JellySlideInPresentationAnimator : UIViewControllerAnimatedTransitioning {
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
        let dismissedFrame = calculateDismissedFrame(from: presentedFrame, usingDirection: self.direction, andContext: transitionContext) // Frame the ViewController will have when he is dismissed
        print(dismissedFrame)
        
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        
        let animationDuration = transitionDuration(using: transitionContext)
        controllerToAnimate.view.frame = initialFrame
        
        var jellyness = Jelly()
        
        if isPresentation {
            jellyness = presentation.jellyness.convertJellyness()
        }
        
        let animationCurve = isPresentation ? presentation.presentationCurve : presentation.dismissCurve
        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: jellyness.damping,
                       initialSpringVelocity: jellyness.velocity,
                       options: animationCurve.getAnimationOptionForJellyCurve(),
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
    private func calculateDismissedFrame(from presentedFrame: CGRect, usingDirection direction: JellyConstants.Direction , andContext transitionContext: UIViewControllerContextTransitioning) -> CGRect {
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
