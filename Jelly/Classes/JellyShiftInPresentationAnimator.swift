//
//  SlideInPresentationAnimator.swift
//  Created by Sebastian Boldt on 18.11.16.

import Foundation

final class JellyShiftInPresentationAnimator: NSObject {
    
    let direction: JellyConstants.Direction
    let presentationType : JellyConstants.PresentationType
    let presentation : JellyShiftInPresentation
    
    init(direction: JellyConstants.Direction, presentationType: JellyConstants.PresentationType, presentation: JellyShiftInPresentation) {
        self.direction = direction
        self.presentationType = presentationType
        self.presentation = presentation
        super.init()
    }
    
}

extension JellyShiftInPresentationAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentation.duration.rawValue
    }
    
    // Refactor this please .... 😡
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
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
        let dismissedFrameForPresented = calculateDismissedFrame(from: presentedFrameForPresented, usingDirection: self.direction, andContext: transitionContext) // Frame the ViewController will have when he is dismissed
        
        var presentedFrameForUnderlying = transitionContext.containerView.frame
        
        switch self.presentation.direction {
        case .left:
            presentedFrameForUnderlying.origin.x = presentedFrameForPresented.origin.x + presentedFrameForPresented.size.width
        case .right:
            presentedFrameForUnderlying.origin.x = presentedFrameForUnderlying.origin.x - presentedFrameForPresented.size.width
        case .top:
            presentedFrameForUnderlying.origin.y = presentedFrameForPresented.origin.y + presentedFrameForPresented.size.height
        case .bottom:
            presentedFrameForUnderlying.origin.y = presentedFrameForUnderlying.origin.y - presentedFrameForPresented.size.height
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
                        
                        presentedViewController.view.frame = finalFrameFoPresented
                        underlyingViewController.view.frame = finalFrameForUnderlying
                        
        }, completion:{ finished in
            transitionContext.completeTransition(finished)
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
    
    private func getPresentedViewControllerKeyForPresentationType(type: JellyConstants.PresentationType) -> UITransitionContextViewControllerKey {
        switch type {
        case .show:
            return .to
        case .dismiss:
            return .from
        }
    }
    
    private func getUnderlyingViewControllerKeyForPresentationType(type: JellyConstants.PresentationType) -> UITransitionContextViewControllerKey {
        switch type {
        case .show:
            return .from
        case .dismiss:
            return .to
        }
    }
}

