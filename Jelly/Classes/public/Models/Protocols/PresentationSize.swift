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

public protocol PresentationWidthProvider {
    var width: Size { get set  }
}

public protocol PresentationHeightProvider {
    var height: Size { get set }
}

public protocol PresentationSizeProtocol: PresentationWidthProvider, PresentationHeightProvider {}

public struct PresentationSize: PresentationSizeProtocol {
    public var width: Size
    public var height: Size
    
    public init(width: Size = .fullscreen,
                height: Size = .fullscreen) {
        self.width = width
        self.height = height
    }
}
