import Foundation

import Foundation
import UIKit

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
    
    public init(cornerRadius: Double, backgroundStyle: Constants.BackgroundStyle, isTapBackgroundToDismissEnabled: Bool, corners: UIRectCorner) {
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.isTapBackgroundToDismissEnabled = isTapBackgroundToDismissEnabled
        self.corners = corners
    }
}
