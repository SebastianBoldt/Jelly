//
//  UIViewControllerAnimatedTransitioning+Extension.swift
//  Pods
//
//  Created by Sebastian Boldt on 23.05.17.
//
//

import Foundation

extension UIViewControllerAnimatedTransitioning {
    func getPresentedViewControllerKeyForPresentationType(type: Constants.PresentationType) -> UITransitionContextViewControllerKey {
        switch type {
            case .show:
                return .to
            case .dismiss:
                return .from
        }
    }
    
    func getUnderlyingViewControllerKeyForPresentationType(type: Constants.PresentationType) -> UITransitionContextViewControllerKey {
        switch type {
            case .show:
                return .from
            case .dismiss:
                return .to
        }
    }
}
