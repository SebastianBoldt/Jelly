//
//  JellyPresentation.swift
//  Created by Sebastian Boldt on 17.11.16.
//

import Foundation

/// The JellyPresentation protocol defines which properties a basic presentation should provide
public protocol JellyPresentation {
    var duration: JellyConstants.Duration { get set }
    var cornerRadius: Double { get set }
    var presentationCurve : JellyConstants.JellyCurve { get set }
    var dismissCurve : JellyConstants.JellyCurve { get set }
    var backgroundStyle : JellyConstants.BackgroundStyle { get set }
    var isTapBackgroundToDismissEnabled : Bool { get set }
    var corners: UIRectCorner { get set }
}
