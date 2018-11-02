import Foundation

import Foundation
import UIKit

public protocol PresentationSpringProvider {
    var spring: Constants.Spring { get set }
}

public protocol PresentationUIConfigurationProvider {
    var presentationUIConfiguration: PresentationUIConfigurationProtocol { get set }
}

public protocol PresentationUIConfigurationProtocol {
    var cornerRadius: Double { get set }
    var backgroundStyle : Constants.BackgroundStyle { get set }
    var isTapBackgroundToDismissEnabled : Bool { get set }
    var corners: UIRectCorner { get set }
}

public struct PresentationUIConfiguration: PresentationUIConfigurationProtocol{
    public var cornerRadius: Double
    public var backgroundStyle: Constants.BackgroundStyle
    public var isTapBackgroundToDismissEnabled: Bool
    public var corners: UIRectCorner
    
    public init(cornerRadius: Double = 0.0, backgroundStyle: Constants.BackgroundStyle = .dimmed(alpha: 0.5), isTapBackgroundToDismissEnabled: Bool = true, corners: UIRectCorner = .allCorners) {
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.isTapBackgroundToDismissEnabled = isTapBackgroundToDismissEnabled
        self.corners = corners
    }
}
