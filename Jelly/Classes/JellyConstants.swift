//
//  JellyStyle.swift
//  Created by Sebastian Boldt on 17.11.16.

import Foundation

public struct JellyConstants {
    
    public enum BackgroundStyle {
        case dimmed
        case blur(effectStyle: UIBlurEffectStyle)
        case none
    }
    
    public enum PresentationType {
        case show
        case dismiss
    }
        
    public enum Direction {
        case top
        case bottom
        case left
        case right
    }
    
    public enum Jellyness {
        case none
        case jelly
        case jellier
        case jelliest
    }
    
    public enum Duration : TimeInterval {
        case ultraSlow = 2.0
        case slow = 1.0
        case normal = 0.35
        case fast = 0.2
        case reallyFast = 0.1
    }
    
    public enum JellyCurve {
        
        case easeInEaseOut
        case easeIn
        case easeOut
        case linear
        
        public func getAnimationOptionForJellyCurve() -> UIViewAnimationOptions {
            switch self {
                case .easeInEaseOut:
                    return .curveEaseInOut
                case .easeIn:
                    return .curveEaseIn
                case .easeOut:
                    return .curveEaseOut
                case .linear:
                    return .curveLinear
            }
        }
    }

}
