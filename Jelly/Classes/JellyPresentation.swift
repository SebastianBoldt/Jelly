//
//  JellyPresentation.swift
//  Created by Sebastian Boldt on 17.11.16.
//

import Foundation

public protocol JellyPresentation {
    var duration: JellyConstants.Duration { get }
    var widthForViewController: JellyConstants.Size { get  }
    var heightForViewController: JellyConstants.Size { get }
    var backgroundStyle : JellyConstants.BackgroundStyle { get }
    var cornerRadius: Double { get }
    var presentationCurve : JellyConstants.JellyCurve { get }
    var dismissCurve : JellyConstants.JellyCurve { get }
}
