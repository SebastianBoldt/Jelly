//
//  JellyPresentation.swift
//  Created by Sebastian Boldt on 17.11.16.

import Foundation

public struct JellyPresentation {
    
    private(set) var jellyness: JellyConstants.Jellyness
    private(set) var duration: JellyConstants.Duration
    private(set) var direction: JellyConstants.Direction
    private(set) var style: JellyConstants.Style
    private(set) var sizeForPresentedVC: CGSize
    
    public init(jellyness: JellyConstants.Jellyness, duration: JellyConstants.Duration, direction: JellyConstants.Direction, style: JellyConstants.Style,sizeForViewController viewControllerSize: CGSize) {
        self.jellyness = jellyness
        self.duration = duration
        self.direction = direction
        self.style = style
        self.sizeForPresentedVC = viewControllerSize
    }
}
