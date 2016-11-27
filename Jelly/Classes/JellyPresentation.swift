//
//  JellyPresentation.swift
//  Created by Sebastian Boldt on 17.11.16.
//

import Foundation



/// The JellyPresentation protocol defines which properties a basic presentation should provide
/// Maybe we could use a class hierarchy to abstract all the different types better than using protocol for that
public protocol JellyPresentation {
    var duration: JellyConstants.Duration { get }
    var widthForViewController: JellyConstants.Size { get  }
    var heightForViewController: JellyConstants.Size { get }
    var backgroundStyle : JellyConstants.BackgroundStyle { get }
    var cornerRadius: Double { get }
    var presentationCurve : JellyConstants.JellyCurve { get }
    var dismissCurve : JellyConstants.JellyCurve { get }
    
    /// If the width or height is bigger than the container we are working in, marginGuards will kick in and limit the size the specified margins 
    var marginGuards: UIEdgeInsets { get }
}

/// If a presentation is Alginable it provides vertical and horizontal alignment options
public protocol AlignablePresentation {
    var verticalAlignemt : JellyConstants.VerticalAlignment { get }
    var horizontalAlignment : JellyConstants.HorizontalAlignment { get }
}
