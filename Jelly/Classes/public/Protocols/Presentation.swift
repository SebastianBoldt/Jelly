//
//  JellyPresentation.swift
//  Created by Sebastian Boldt on 17.11.16.
//

import Foundation
import UIKit

/// The Presentation protocol defines which properties a basic presentation should provide
public protocol Presentation {
    var duration: Constants.Duration { get set }
    var cornerRadius: Double { get set }
    var presentationCurve : UIView.AnimationCurve { get set }
    var dismissCurve : UIView.AnimationCurve { get set }
    var backgroundStyle : Constants.BackgroundStyle { get set }
    var isTapBackgroundToDismissEnabled : Bool { get set }
    var corners: UIRectCorner { get set }
}
