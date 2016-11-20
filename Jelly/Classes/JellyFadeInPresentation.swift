//
//  JellyFadeInPresentation.swift
//  Created by Sebastian Boldt on 20.11.16.
//

import Foundation

public struct JellyFadeInPresentation: JellyPresentation {
    
    // Jelly Presentation Protocol conformance
    public private(set) var dismissCurve: JellyConstants.JellyCurve = .linear
    public private(set) var presentationCurve: JellyConstants.JellyCurve = .linear
    public private(set) var cornerRadius: Double = 0.0
    public private(set) var backgroundStyle: JellyConstants.BackgroundStyle = .dimmed
    public private(set) var duration : JellyConstants.Duration = .normal // Duration the ViewController needs to kick in
    public private(set) var sizeForViewController: CGSize = CGSize(width: 300, height: 300) // Size for the presented ViewController
    
    public init(dismissCurve: JellyConstants.JellyCurve = .linear,
                presentationCurve: JellyConstants.JellyCurve = .linear,
                cornerRadius: Double = 0.0,
                backgroundStyle: JellyConstants.BackgroundStyle = .dimmed,
                duration: JellyConstants.Duration = .normal,
                sizeForViewController: CGSize = CGSize(width:300,height:300)) {
        
        self.dismissCurve = dismissCurve
        self.presentationCurve = presentationCurve
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.duration = duration
        self.sizeForViewController = sizeForViewController
    }
    
}
