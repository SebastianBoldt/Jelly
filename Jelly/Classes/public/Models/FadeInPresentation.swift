//
//  JellyFadeInPresentation.swift
//  Created by Sebastian Boldt on 20.11.16.
//

import UIKit

public struct FadeInPresentation: Presentation, AlignablePresentation, DynamicPresentation {
    
    // Presentation Protocol conformance
    public var dismissCurve: UIView.AnimationCurve = .linear
    public var presentationCurve: UIView.AnimationCurve = .linear
    public var cornerRadius: Double = 0.0
    public var backgroundStyle: Constants.BackgroundStyle = .dimmed(alpha: 0.5)
    public var duration : Constants.Duration = .normal // Duration the ViewController needs to kick in
    public var widthForViewController: Constants.Size = .halfscreen
    public var heightForViewController: Constants.Size = .halfscreen
    public var marginGuards: UIEdgeInsets = .zero
    public var isTapBackgroundToDismissEnabled: Bool = true
    public var corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
    
    // Alginable
    public var horizontalAlignment: Constants.HorizontalAlignment = .center
    public var verticalAlignemt: Constants.VerticalAlignment = .center
    
    public init(dismissCurve: UIView.AnimationCurve = .linear,
                presentationCurve: UIView.AnimationCurve = .linear,
                cornerRadius: Double = 0.0,
                backgroundStyle: Constants.BackgroundStyle = .dimmed(alpha: 0.5),
                duration: Constants.Duration = .normal,
                widthForViewController: Constants.Size = .fullscreen,
                heightForViewController: Constants.Size = .fullscreen,
                horizontalAlignment: Constants.HorizontalAlignment = .center,
                verticalAlignment: Constants.VerticalAlignment = .center,
                marginGuards: UIEdgeInsets = .zero,
                corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]) {
        
        self.dismissCurve = dismissCurve
        self.presentationCurve = presentationCurve
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.duration = duration
        self.widthForViewController = widthForViewController
        self.heightForViewController = heightForViewController
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignemt = verticalAlignment
        self.marginGuards = marginGuards
        self.corners = corners
    }
    
}
