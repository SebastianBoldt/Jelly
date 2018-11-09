import Foundation

public protocol PresentationAlignmentProvider {
    var presentationAlignment: PresentationAlignmentProtocol { get set }
}

public protocol PresentationAlignmentProtocol {
    var verticalAlignemt : VerticalAlignment { get set }
    var horizontalAlignment : HorizontalAlignment { get set }
}
