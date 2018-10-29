//
//  Constants.swift
//  Created by Sebastian Boldt on 17.11.16.

import Foundation

/// Datamodel Types which will be used to create a PresentationObject

public struct Constants {
    public enum HorizontalAlignment {
        case left
        case right
        case center
        case custom(x: CGFloat)
    }
    
    public enum VerticalAlignment {
        case top
        case bottom
        case center
        case custom(y: CGFloat)
    }
    
    public enum Size {
        case fullscreen
        case halfscreen
        case custom(value: CGFloat)
    }
    
    public enum BackgroundStyle {
        case dimmed(alpha: CGFloat)
        case blurred(effectStyle: UIBlurEffect.Style)
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
    
    public enum Spring {
        case none
        case tight
        case medium
        case loose
        
        var damping: CGFloat {
            switch self {
                case .none:
                    return 1.0
                case .tight:
                    return 0.7
                case .medium:
                    return 0.5
                case .loose:
                    return 0.2
            }
        }
        
        var velocity: CGFloat {
            switch self {
            case .none:
                return 0
            case .tight:
                return 1
            case .medium:
                return 3
            case .loose:
                return 4
            }
        }
    }
    
    public enum Duration: TimeInterval {
        case ultraSlow = 2.0
        case slow = 1.0
        case medium = 0.5
        case normal = 0.35
        case fast = 0.2
        case reallyFast = 0.1
    }
}
