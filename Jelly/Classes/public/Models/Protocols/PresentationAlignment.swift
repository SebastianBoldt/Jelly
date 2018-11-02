import Foundation

public protocol PresentationAlignmentProvider {
    var presentationAlignment: PresentationAlignmentProtocol { get set }
}

public protocol PresentationAlignmentProtocol {
    var verticalAlignemt : VerticalAlignment { get set }
    var horizontalAlignment : HorizontalAlignment { get set }
}

public struct PresentationAlignment: PresentationAlignmentProtocol {
    public var verticalAlignemt: VerticalAlignment
    public var horizontalAlignment: HorizontalAlignment
    
    public static var centerAlignment: PresentationAlignment {
        return PresentationAlignment(vertical: .center, horizontal: .center)
    }
    
    public init(vertical: VerticalAlignment, horizontal: HorizontalAlignment) {
        self.verticalAlignemt = vertical
        self.horizontalAlignment = horizontal
    }
}
