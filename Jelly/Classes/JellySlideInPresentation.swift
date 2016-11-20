//
//  JellySlideInPresentation.swift
//  Created by Sebastian Boldt on 20.11.16.
//

public struct JellySlideInPresentation: JellyPresentation {
    
    // JellyPresentation Protocol conformance
    public private(set) var dismissCurve: JellyConstants.JellyCurve = .linear
    public private(set) var presentationCurve: JellyConstants.JellyCurve = .linear
    public private(set) var cornerRadius: Double = 0.0
    public private(set) var backgroundStyle: JellyConstants.BackgroundStyle = .none
    public private(set) var jellyness: JellyConstants.Jellyness
    public private(set) var duration : JellyConstants.Duration = .normal // Duration the ViewController needs to kick in
    public private(set) var sizeForViewController: CGSize = CGSize(width: 300, height: 600) // Size for the presented ViewController
    
    // Unique
    public private(set) var directionShow: JellyConstants.Direction = .left // Direction the ViewController slides in from
    public private(set) var directionDismiss: JellyConstants.Direction = .left // Direction the ViewController slides out to
    
    public init(dismissCurve: JellyConstants.JellyCurve = .linear,
                presentationCurve: JellyConstants.JellyCurve = .linear,
                cornerRadius: Double = 0.0,
                backgroundStyle: JellyConstants.BackgroundStyle = .dimmed,
                jellyness: JellyConstants.Jellyness = .none,
                duration: JellyConstants.Duration = .normal,
                sizeForViewController: CGSize = CGSize(width:300,height:300),
                directionShow: JellyConstants.Direction = .top,
                directionDismiss: JellyConstants.Direction = .top) {
        
        self.dismissCurve = dismissCurve
        self.presentationCurve = presentationCurve
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.jellyness = jellyness
        self.duration = duration
        self.sizeForViewController = sizeForViewController
        self.directionShow = directionShow
        self.directionDismiss = directionDismiss
    }
}
