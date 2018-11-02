import Foundation

public protocol PresentationAlignmentProvider {
    var presentationAlignment: PresentationAlignmentProtocol { get set }
}

public protocol PresentationAlignmentProtocol {
    var verticalAlignemt : Constants.VerticalAlignment { get set }
    var horizontalAlignment : Constants.HorizontalAlignment { get set }
}

public struct PresentationAlignment: PresentationAlignmentProtocol {
    public var verticalAlignemt: Constants.VerticalAlignment
    public var horizontalAlignment: Constants.HorizontalAlignment
    
    public static var centerAlignment: PresentationAlignment {
        return PresentationAlignment(vertical: .center, horizontal: .center)
    }
    
    public init(vertical: Constants.VerticalAlignment, horizontal: Constants.HorizontalAlignment) {
        self.verticalAlignemt = vertical
        self.horizontalAlignment = horizontal
    }
}
