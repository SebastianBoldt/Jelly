//
//  UIViewControllerAnimatedTransitioning+Extension.swift
//  Pods
//
//  Created by Sebastian Boldt on 23.05.17.
//
//

import Foundation

public extension UIViewControllerAnimatedTransitioning {
    public func getPresentedViewControllerKeyForPresentationType(type: JellyConstants.PresentationType) -> UITransitionContextViewControllerKey {
        switch type {
            case .show:
                return .to
            case .dismiss:
                return .from
        }
    }
    
    public func getUnderlyingViewControllerKeyForPresentationType(type: JellyConstants.PresentationType) -> UITransitionContextViewControllerKey {
        switch type {
            case .show:
                return .from
            case .dismiss:
                return .to
        }
    }
}
