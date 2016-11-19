//
//  JellyPresentation.swift
//  Created by Sebastian Boldt on 17.11.16.

import Foundation

public struct JellyPresentation {
    
    private(set) var jellyness: JellyConstants.Jellyness
    private(set) var duration: JellyConstants.Duration
    private(set) var directionShow: JellyConstants.Direction
    private(set) var directionDismiss: JellyConstants.Direction
    private(set) var style: JellyConstants.Style
    private(set) var sizeForPresentedVC: CGSize
    private(set) var isDimmingViewAnimationEnabled: Bool = false
    private(set) var cornerRadius: Double = 0.0
    private(set) var curve : JellyConstants.JellyCurve = .EaseInEaseOut
    private(set) var backgroundStyle : JellyConstants.BackgroundStyle
    
    public init(jellyness: JellyConstants.Jellyness,
                duration: JellyConstants.Duration,
                directionShow: JellyConstants.Direction,
                directionDismiss: JellyConstants.Direction,
                style: JellyConstants.Style,
                curve: JellyConstants.JellyCurve,
                sizeForViewController viewControllerSize: CGSize,
                cornerRadius: Double = 0.0,
                backgroundStyle: JellyConstants.BackgroundStyle = .dimmed) {
        
        self.jellyness = jellyness
        self.duration = duration
        self.directionShow = directionShow
        self.directionDismiss = directionDismiss
        self.style = style
        self.curve = curve
        self.sizeForPresentedVC = viewControllerSize
        self.backgroundStyle = backgroundStyle
        self.cornerRadius = cornerRadius
    }
}
