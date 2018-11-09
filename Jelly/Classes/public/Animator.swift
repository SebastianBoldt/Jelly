import UIKit

public protocol AnimatorProtocol {
    init(presentation: Presentation)
}

public protocol LiveUpdatable {
    func prepare(presentedViewController: UIViewController)
    func updateAlignment(alignment: PresentationAlignmentProtocol, duration: Duration) throws
    func updateVerticalAlignment(alignment: VerticalAlignment, duration: Duration) throws
    func updateHorizontalAlignment(alignment: HorizontalAlignment, duration: Duration) throws
    func updateSize(presentationSize: PresentationSize, duration: Duration) throws
    func updateWidth(width: Size, duration: Duration) throws
    func updateHeight(height: Size, duration: Duration) throws
    func updateMarginGuards(marginGuards: UIEdgeInsets, duration: Duration) throws
    func updateCorners(radius: CGFloat, corners: CACornerMask, duration: Duration)
}

/// # Animator
/// An Animator is an UIViewControllerTransitionsDelegate with some extra candy.
/// Basically the Animator is the main class to use when working with Jelly.
public class Animator: NSObject {
    private var presentation: Presentation
    
    private var currentPresentationController: PresentationController!
    private weak var presentedViewController: UIViewController!
    
    private var showInteractionController: InteractionController?
    private var dismissInteractionController: InteractionController?

    /// ## designated initializer
    /// - Parameter presentation: a custom Presentation Object
    public init(presentation: Presentation) {
        self.presentation = presentation
        super.init()
    }
    
    /// ## prepare
    /// Call this function to prepare the viewController you want to present
    /// - Parameter viewController: presentedViewController that should be presented in a custom way
    public func prepare(presentedViewController: UIViewController) {
        // Create InteractionController over here because it needs a reference to the PresentationController
        if let interactivePresentation = presentation as? (PresentationShowDirectionProvider & InteractionConfigurationProvider),
            let configuration = interactivePresentation.interactionConfiguration, let presentingViewController = configuration.presentingViewController {
            self.showInteractionController = InteractionController(configuration: configuration, presentedViewController: presentedViewController, presentingViewController: presentingViewController, presentationType: .show, presentation: interactivePresentation, presentationController: nil)
        }
        presentedViewController.modalPresentationStyle = .custom
        presentedViewController.transitioningDelegate = self
        self.presentedViewController = presentedViewController
    }
}

/// ## UIViewControllerTransitioningDelegate Implementation
/// The Animator needs to conform to the UIViewControllerTransitioningDelegate protocol
/// it will provide a custom Presentation-Controller that tells UIKit which extra Views the presentation should have
/// it also returns the interaction controllers for interaction with via gesuture recognizers
extension Animator: UIViewControllerTransitioningDelegate {
    /// Gets called from UIKit if presentatioStyle is custom and transitionDelegate is set
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = PresentationController(presentedViewController: presented, presentingViewController: presenting, presentation: presentation)
        currentPresentationController = presentationController
        if let interactivePresentation = presentation as? (InteractionConfigurationProvider & PresentationShowDirectionProvider),
            let configuration = interactivePresentation.interactionConfiguration, let presentingViewController = configuration.presentingViewController {
            self.dismissInteractionController = InteractionController(configuration: configuration, presentedViewController: presentedViewController, presentingViewController: presentingViewController, presentationType: .dismiss, presentation: interactivePresentation, presentationController: currentPresentationController)
        }
        return presentationController
    }
    
    /// Each Presentation has two directions
    /// Inside a Presention Object you can specify some extra parameters
    /// This Parameters will be passed to a custom animator that handles the presentation animation (duration, direction etc.)
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {        
        return presentation.showAnimator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentation.dismissAnimator
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard dismissInteractionController?.interactionInProgress == true else {
            return nil
        }
        return dismissInteractionController
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard showInteractionController?.interactionInProgress == true else {
            return nil
        }
        return showInteractionController
    }
}

extension Animator: LiveUpdatable {
    public func updateAlignment(alignment: PresentationAlignmentProtocol, duration: Duration) throws {
        guard !(presentation is SlidePresentation), var presentation = presentation as? (Presentation & PresentationAlignmentProvider) else {
            throw LiveUpdateError.notSupportedOnSlide
        }
        
        presentation.presentationAlignment = alignment
        self.presentation = presentation
        currentPresentationController.updatePresentation(presentation: presentation, duration: duration)
    }
    
    public func updateVerticalAlignment(alignment: VerticalAlignment, duration: Duration) throws {
        guard !(presentation is SlidePresentation), var presentation = presentation as? (Presentation & PresentationAlignmentProvider) else {
            throw LiveUpdateError.notSupportedOnSlide
        }
        
        presentation.presentationAlignment = PresentationAlignment(vertical: alignment, horizontal: presentation.presentationAlignment.horizontalAlignment)
        self.presentation = presentation
        currentPresentationController.updatePresentation(presentation: presentation, duration: duration)
    }
    
    public func updateHorizontalAlignment(alignment: HorizontalAlignment, duration: Duration) throws {
        guard !(presentation is SlidePresentation), var presentation = presentation as? (Presentation & PresentationAlignmentProvider) else {
            throw LiveUpdateError.notSupportedOnSlide
        }
        
        presentation.presentationAlignment = PresentationAlignment(vertical: presentation.presentationAlignment.verticalAlignemt, horizontal: alignment)
        self.presentation = presentation
        currentPresentationController.updatePresentation(presentation: presentation, duration: duration)
    }
    
    public func updateSize(presentationSize: PresentationSize, duration: Duration) throws {
        guard !(presentation is SlidePresentation), var presentation = presentation as? (PresentationSizeProvider & Presentation) else {
            throw LiveUpdateError.notSupportedOnSlide
        }
        
        presentation.presentationSize = presentationSize
        self.presentation = presentation
        currentPresentationController.updatePresentation(presentation: presentation, duration: duration)
    }
    
    public func updateWidth(width: Size, duration: Duration) throws {
        guard !(presentation is SlidePresentation) else {
            throw LiveUpdateError.notSupportedOnSlide
        }
        
        if var presentation = presentation as? FadePresentation {
            presentation.presentationSize = PresentationSize(width: width, height: presentation.presentationSize.height)
            self.presentation = presentation
            currentPresentationController.updatePresentation(presentation: presentation, duration: duration)
        } else if var presentation = presentation as? CoverPresentation {
            presentation.presentationSize = PresentationSize(width: width, height: presentation.presentationSize.height)
            self.presentation = presentation
            currentPresentationController.updatePresentation(presentation: presentation, duration: duration)
        }
    }
    
    public func updateHeight(height: Size, duration: Duration) throws {
        guard !(presentation is SlidePresentation) else {
            throw LiveUpdateError.notSupportedOnSlide
        }

        if var presentation = presentation as? FadePresentation {
            presentation.presentationSize = PresentationSize(width: presentation.presentationSize.height, height: height)
            self.presentation = presentation
            currentPresentationController.updatePresentation(presentation: presentation, duration: duration)
        } else if var presentation = presentation as? CoverPresentation {
            presentation.presentationSize = PresentationSize(width: presentation.presentationSize.height, height: height)
            self.presentation = presentation
            currentPresentationController.updatePresentation(presentation: presentation, duration: duration)
        }
    }
    
    public func updateMarginGuards(marginGuards: UIEdgeInsets, duration: Duration) throws {
        guard !(presentation is SlidePresentation), var presentation = presentation as? (Presentation & PresentationMarginGuardsProvider) else {
            throw LiveUpdateError.notSupportedOnSlide
        }
        
        presentation.marginGuards = marginGuards
        self.presentation = presentation
        currentPresentationController.updatePresentation(presentation: presentation, duration: duration)
    }
    
    public func updateCorners(radius: CGFloat, corners: CACornerMask, duration: Duration) {
        var presentation = self.presentation
        presentation.presentationUIConfiguration.cornerRadius = radius
        presentation.presentationUIConfiguration.corners = corners
        self.presentation = presentation
        currentPresentationController.updatePresentation(presentation: presentation, duration: duration)
    }

}
