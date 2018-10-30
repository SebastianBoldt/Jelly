import Foundation

public protocol PresentationSizeProvider {
    var presentationSize: PresentationSizeProtocol { get set }
}

public protocol PresentationMarginGuardsProvider {
    /*
     If the width or height is bigger than the container we are working in,
     marginGuards will kick in and limit the size the specified margins
     */
    var marginGuards: UIEdgeInsets { get set }
}

public protocol PresentationSizeProtocol {
    var width: Constants.Size { get set  }
    var height: Constants.Size { get set }
}

public struct PresentationSize: PresentationSizeProtocol {
    public var width: Constants.Size
    public var height: Constants.Size
    
    public init(width: Constants.Size, height: Constants.Size) {
        self.width = width
        self.height = height
    }
}
