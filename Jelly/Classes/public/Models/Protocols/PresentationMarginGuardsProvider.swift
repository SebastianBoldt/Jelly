import UIKit

public protocol PresentationMarginGuardsProvider {
    /*
     If the width or height is bigger than the container we are working in,
     marginGuards will kick in and limit the size the specified margins
     */
    var marginGuards: UIEdgeInsets { get set }
}
