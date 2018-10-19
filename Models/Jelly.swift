//
//  Jelly.swift
//  Created by Sebastian Boldt on 18.11.16.

import Foundation

public struct Jelly {
    
    public var damping: CGFloat
    public var velocity: CGFloat
    
    init(damping: CGFloat = 1.0, velocity: CGFloat = 1.0) {
        self.damping = damping
        self.velocity = velocity
    }
}
