import UIKit

public protocol PresentationUIConfigurationProtocol {
    var cornerRadius: CGFloat { get set }
    var backgroundStyle: BackgroundStyle { get set }
    var isTapBackgroundToDismissEnabled: Bool { get set }
    var corners: CACornerMask { get set }
}

public struct PresentationUIConfiguration: PresentationUIConfigurationProtocol {
    public var cornerRadius: CGFloat
    public var backgroundStyle: BackgroundStyle
    public var isTapBackgroundToDismissEnabled: Bool
    public var corners: CACornerMask

    public init(cornerRadius: CGFloat = 0.0, backgroundStyle: BackgroundStyle = .dimmed(alpha: 0.5), isTapBackgroundToDismissEnabled: Bool = true, corners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]) {
        self.cornerRadius = cornerRadius
        self.backgroundStyle = backgroundStyle
        self.isTapBackgroundToDismissEnabled = isTapBackgroundToDismissEnabled
        self.corners = corners
    }
}
