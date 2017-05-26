//
//  JellyPresentation.swift
//  Created by Sebastian Boldt on 17.11.16.
//

import Foundation

/// The JellyPresentation protocol defines which properties a basic presentation should provide
/// Maybe we could use a class hierarchy to abstract all the different types better than using protocols for that
public protocol JellyPresentation {
    var duration: JellyConstants.Duration { get set }
    var cornerRadius: Double { get set }
    var presentationCurve : JellyConstants.JellyCurve { get set }
    var dismissCurve : JellyConstants.JellyCurve { get set }
    var backgroundStyle : JellyConstants.BackgroundStyle { get set }
    var isTapBackgroundToDismissEnabled : Bool { get set }
    var corners: UIRectCorner { get set }
}

/// If a presentation is Alginable it provides vertical and horizontal alignment options
public protocol AlignablePresentation {
    var verticalAlignemt : JellyConstants.VerticalAlignment { get set }
    var horizontalAlignment : JellyConstants.HorizontalAlignment { get set }
}

public protocol DynamicPresentation {
    var widthForViewController: JellyConstants.Size { get set  }
    var heightForViewController: JellyConstants.Size { get set }
    /// If the width or height is bigger than the container we are working in, marginGuards will kick in and limit the size the specified margins
    var marginGuards: UIEdgeInsets { get set }
}

public enum PresentationType {
    case fade
    case shift
    case slide
}
