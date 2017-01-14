//
//  JellyStyle.swift
//  Created by Sebastian Boldt on 17.11.16.

import Foundation

/// Datamodel Types which will be used to create a JellyPresentationObject
public struct JellyConstants {
    
    public enum HorizontalAlignment {
        case left
        case right
        case center
    }
    
    public enum VerticalAlignment {
        case top
        case bottom
        case center
    }
    
    public enum Size {
        case fullscreen
        case halfscreen
        case custom(value: CGFloat)
    }
    
    public enum BackgroundStyle {
        case dimmed(alpha: CGFloat)
        case blur(effectStyle: UIBlurEffectStyle)
    }
    
    /// Will the ViewController be shown or dismissed?
    public enum PresentationType {
        case show
        case dismiss
    }
    
    /// Direction the Viewcontroller should fly out or come in from
    public enum Direction {
        case top
        case bottom
        case left
        case right
        
        public func orientation() -> Orientation {
            switch self {
            case .left, .right :
                return .horizontal
            case .top, .bottom :
                return .vertical
            }
        }
    }
    
    public enum Orientation {
        case horizontal
        case vertical
    }
    
    public enum Jellyness {
        case none
        case jelly
        case jellier
        case jelliest
        
        func convertJellyness() -> Jelly {
            
            var damping = 1.0
            var velocity = 0
            
            switch self {
            case .none:
                ()
            case .jelly:
                damping = 0.7
                velocity = 2
            case .jellier:
                damping = 0.5
                velocity = 3
            case .jelliest:
                damping = 0.2
                velocity = 4
            }
            
            return Jelly(damping:CGFloat(damping),velocity:CGFloat(velocity))
        }
    }
    
    public enum Duration : TimeInterval {
        case ultraSlow = 2.0
        case slow = 1.0
        case medium = 0.5
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
