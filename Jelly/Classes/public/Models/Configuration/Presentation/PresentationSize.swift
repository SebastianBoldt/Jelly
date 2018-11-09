import Foundation

public struct PresentationSize: PresentationSizeProtocol {
    public var width: Size
    public var height: Size
    
    public init(width: Size = .fullscreen,
                height: Size = .fullscreen) {
        self.width = width
        self.height = height
    }
}
