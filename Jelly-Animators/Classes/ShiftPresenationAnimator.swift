//
//  ShifPresenationAnimator.swift
//  Created by Sebastian Boldt on 18.11.16.

import Foundation


final class ShiftPresentationAnimator: NSObject {
    
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

extension ShiftPresentationAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return presentation.duration.rawValue
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Animate shift transition
    }
}
