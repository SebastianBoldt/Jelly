//
//  JellyStyle.swift
//  Created by Sebastian Boldt on 17.11.16.

import Foundation

public struct JellyConstants {
    
    public enum Style {
       case slidein
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

}
