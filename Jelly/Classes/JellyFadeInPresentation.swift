//
//  JellyFadeInPresentation.swift
//  Created by Sebastian Boldt on 20.11.16.
//

import Foundation

public struct JellyFadeInPresentation: JellyPresentation, AlignablePresentation, DynamicPresentation {
    
    // Jelly Presentation Protocol conformance
    public var dismissCurve: JellyConstants.JellyCurve = .linear
    public var presentationCurve: JellyConstants.JellyCurve = .linear
    public var cornerRadius: Double = 0.0
  public var backgroundStyle: JellyConstants.BackgroundStyle = .dimmed(alpha: 0.5)
    public var duration : JellyConstants.Duration = .normal // Duration the ViewController needs to kick in
    public var widthForViewController: JellyConstants.Size = .halfscreen
    public var heightForViewController: JellyConstants.Size = .halfscreen
    public var marginGuards: UIEdgeInsets = .zero
    public var isTapBackgroundToDismissEnabled: Bool = true
    public var corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
    
    // Alginable
    public var horizontalAlignment: JellyConstants.HorizontalAlignment = .center
    public var verticalAlignemt: JellyConstants.VerticalAlignment = .center
    
    public init(dismissCurve: JellyConstants.JellyCurve = .linear,
                presentationCurve: JellyConstants.JellyCurve = .linear,
                cornerRadius: Double = 0.0,
                backgroundStyle: JellyConstants.BackgroundStyle = .dimmed(alpha: 0.5),
                duration: JellyConstants.Duration = .normal,
                widthForViewController: JellyConstants.Size = .fullscreen,
                heightForViewController: JellyConstants.Size = .fullscreen,
                marginGuards: UIEdgeInsets = .zero,
                corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]) {
        
        self.dismissCurve = dismissCurve
        self.presentationCurve = presentationCurve
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.duration = duration
        self.widthForViewController = widthForViewController
        self.heightForViewController = heightForViewController
        self.marginGuards = marginGuards
        self.corners = corners
    }
    
}
