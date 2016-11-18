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
        let damping = 0.2
        let velocity = 5
        
        return Jelly(damping:CGFloat(damping),velocity:CGFloat(velocity))
    }
}
