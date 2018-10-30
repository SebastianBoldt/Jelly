import UIKit

public protocol PresentationShowDirectionProvider {
    var showDirection: Constants.Direction { get set }
}

public protocol PresentationDismissDirectionProvider {
    var dismissDirection: Constants.Direction { get set }
}

