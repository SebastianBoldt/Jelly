import Foundation

public protocol PresentationAlignmentProvider {
    var presentationAlignment: PresentationAlignmentProtocol { get set }
}

public protocol PresentationAlignmentProtocol {
    var verticalAlignemt : Constants.VerticalAlignment { get set }
    var horizontalAlignment : Constants.HorizontalAlignment { get set }
}

public struct PresenstationAlignment: PresentationAlignmentProtocol {
    public var verticalAlignemt: Constants.VerticalAlignment
    public var horizontalAlignment: Constants.HorizontalAlignment
    
    public static var centerAlignment: PresenstationAlignment {
        return PresenstationAlignment(verticalAlignemt: .center, horizontalAlignment: .center)
    }
}
