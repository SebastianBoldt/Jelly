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
    
    public enum Style {
       case slidein
       case fade
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
    
    public enum Duration : Double {
        case ultraSlow = 2.0
        case slow = 1.0
        case medium = 0.5
        case fast = 0.2
        case reallyFast = 0.1
    }
    
    public enum JellyCurve {
        
        case EaseInEaseOut
        case EaseIn
        case EaseOut
        case Linear
        
        public func getAnimationOptionForJellyCurve() -> UIViewAnimationOptions {
            switch self {
                case .EaseInEaseOut:
                    return .curveEaseInOut
                case .EaseIn:
                    return .curveEaseIn
                case .EaseOut:
                    return .curveEaseOut
                case .Linear:
                    return .curveLinear
            }
        }
    }

}
