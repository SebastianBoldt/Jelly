import UIKit

public struct InteractionConfiguration {
    let completionThreshold: CGFloat
    let dragMode: DragMode
    let mode: InteractionMode

    weak var presentingViewController: UIViewController!

    public init(presentingViewController: UIViewController, completionThreshold: CGFloat = 0.5, dragMode: DragMode, mode: InteractionMode = [.dismiss, .present]) {
        self.completionThreshold = completionThreshold
        self.dragMode = dragMode
        self.presentingViewController = presentingViewController
        self.mode = mode
    }
}
