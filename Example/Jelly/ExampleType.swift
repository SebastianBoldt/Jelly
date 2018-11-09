import Foundation

enum ExampleType {
    case interactive(type: InteractiveType)
    case nonInteractive(type: NotInteractiveType)
    case liveUpdate(type: LiveUpdateType)
}

enum InteractiveType {
    case slideMenuFromRightEdge
    case coverMenuFromRightCanvas
    case notificationFromTopCanvas
    case multipleDirectionsCoverCanvas
}

enum NotInteractiveType {
    case coverFromBottom
    case slideFromRight
}

enum LiveUpdateType {
    case updateSize
    case updateAlignment
    case updateMarginGuards
    case updateCornerRadius
}
