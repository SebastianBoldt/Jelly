import UIKit

public protocol PresentationShowDirectionProvider {
    var showDirection: Direction { get set }
}

public protocol PresentationDismissDirectionProvider {
    var dismissDirection: Direction { get set }
}

