//
//  JellySlideInPresentation.swift
//  Created by Sebastian Boldt on 20.11.16.
//

public struct JellySlideInPresentation: JellyPresentation, AlignablePresentation, DynamicPresentation {
    
    // JellyPresentation Protocol conformance
    public   var dismissCurve: JellyConstants.JellyCurve = .linear
    public   var presentationCurve: JellyConstants.JellyCurve = .linear
    public   var cornerRadius: Double = 0.0
    public   var backgroundStyle: JellyConstants.BackgroundStyle = .none
    public   var jellyness: JellyConstants.Jellyness
    public   var duration : JellyConstants.Duration = .normal // Duration the ViewController needs to kick in
    public   var widthForViewController: JellyConstants.Size = .halfscreen
    public   var heightForViewController: JellyConstants.Size = .halfscreen
    public   var isTapBackgroundToDismissEnabled: Bool = true
    public   var marginGuards: UIEdgeInsets = .zero
    public   var corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]

    // Unique
    public   var directionShow: JellyConstants.Direction = .left // Direction the ViewController slides in from
    public   var directionDismiss: JellyConstants.Direction = .left // Direction the ViewController slides out to
    
    // Alginable
    public   var horizontalAlignment: JellyConstants.HorizontalAlignment = .center
    public   var verticalAlignemt: JellyConstants.VerticalAlignment = .center
    
    public init(dismissCurve: JellyConstants.JellyCurve = .linear,
                presentationCurve: JellyConstants.JellyCurve = .linear,
                cornerRadius: Double = 0.0,
                backgroundStyle: JellyConstants.BackgroundStyle = .dimmed,
                jellyness: JellyConstants.Jellyness = .none,
                duration: JellyConstants.Duration = .normal,
                directionShow: JellyConstants.Direction = .top,
                directionDismiss: JellyConstants.Direction = .top,
                widthForViewController: JellyConstants.Size = .fullscreen,
                heightForViewController: JellyConstants.Size = .fullscreen,
                horizontalAlignment: JellyConstants.HorizontalAlignment = .center,
                verticalAlignment: JellyConstants.VerticalAlignment = .center,
                marginGuards: UIEdgeInsets = .zero,
                corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]) {
        
        self.dismissCurve = dismissCurve
        self.presentationCurve = presentationCurve
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.jellyness = jellyness
        self.duration = duration
        self.directionShow = directionShow
        self.directionDismiss = directionDismiss
        self.widthForViewController = widthForViewController
        self.heightForViewController = heightForViewController
        self.verticalAlignemt = verticalAlignment
        self.horizontalAlignment = horizontalAlignment
        self.marginGuards = marginGuards
        self.corners = corners
    }
}
