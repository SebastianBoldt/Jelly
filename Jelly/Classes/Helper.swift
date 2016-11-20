//
//  JellynessConverter.swift
//  Pods
//
//  Created by Sebastian Boldt on 18.11.16.
//
//

import Foundation

public struct Helper {
    static func convertJellyness(jellyness: JellyConstants.Jellyness) -> Jelly {
        
        var damping = 1.0
        var velocity = 0
        
        switch jellyness {
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
