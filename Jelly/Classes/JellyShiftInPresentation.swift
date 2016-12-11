//
//  JellyShiftInPresentation.swift
//  Pods
//
//  Created by Sebastian Boldt on 11.12.16.
//
//

import Foundation

public struct JellyShiftInPresentation: JellyPresentation {
    public  var dismissCurve: JellyConstants.JellyCurve = .linear
    public  var presentationCurve: JellyConstants.JellyCurve = .linear
    public  var cornerRadius: Double = 0.0
    public  var backgroundStyle: JellyConstants.BackgroundStyle = .none
    public  var jellyness: JellyConstants.Jellyness
    public  var duration : JellyConstants.Duration = .normal // Duration the ViewController needs to kick in
    public  var isTapBackgroundToDismissEnabled: Bool = true
    public  var direction : JellyConstants.Direction = .left
    public  var ratio: CGFloat = 1/3
    
    public init(dismissCurve: JellyConstants.JellyCurve = .linear,
                presentationCurve: JellyConstants.JellyCurve = .linear,
                cornerRadius: Double = 0.0,
                backgroundStyle: JellyConstants.BackgroundStyle = .dimmed,
                jellyness: JellyConstants.Jellyness = .none,
                duration: JellyConstants.Duration = .normal,
                direction: JellyConstants.Direction = .left,
                ratio: CGFloat = 1/3) {
        
        self.dismissCurve = dismissCurve
        self.presentationCurve = presentationCurve
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.jellyness = jellyness
        self.duration = duration
        self.direction = direction
        self.ratio = ratio
    }
}
