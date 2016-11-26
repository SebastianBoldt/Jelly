//
//  JellyFadeInPresentation.swift
//  Created by Sebastian Boldt on 20.11.16.
//

import Foundation

public struct JellyFadeInPresentation: JellyPresentation, AlignablePresentation {
    
    // Jelly Presentation Protocol conformance
    public private(set) var dismissCurve: JellyConstants.JellyCurve = .linear
    public private(set) var presentationCurve: JellyConstants.JellyCurve = .linear
    public private(set) var cornerRadius: Double = 0.0
    public private(set) var backgroundStyle: JellyConstants.BackgroundStyle = .dimmed
    public private(set) var duration : JellyConstants.Duration = .normal // Duration the ViewController needs to kick in
    public private(set) var widthForViewController: JellyConstants.Size = .halfscreen
    public private(set) var heightForViewController: JellyConstants.Size = .halfscreen
    public private(set) var margins: UIEdgeInsets = .zero

    // Alginable
    public private(set) var horizontalAlignment: JellyConstants.HorizontalAlignment = .center
    public private(set) var verticalAlignemt: JellyConstants.VerticalAlignment = .center
    
    public init(dismissCurve: JellyConstants.JellyCurve = .linear,
                presentationCurve: JellyConstants.JellyCurve = .linear,
                cornerRadius: Double = 0.0,
                backgroundStyle: JellyConstants.BackgroundStyle = .dimmed,
                duration: JellyConstants.Duration = .normal,
                widthForViewController: JellyConstants.Size = .fullscreen,
                heightForViewController: JellyConstants.Size = .fullscreen,
                margins: UIEdgeInsets = .zero) {
        
        self.dismissCurve = dismissCurve
        self.presentationCurve = presentationCurve
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.duration = duration
        self.widthForViewController = widthForViewController
        self.heightForViewController = heightForViewController
        self.margins = margins
    }
    
}
