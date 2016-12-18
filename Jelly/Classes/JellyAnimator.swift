//  JellyAnimator.swift
//  Created by Sebastian Boldt on 17.11.16.

import UIKit

/// # JellyAnimator
/// A JellyAnimator is an UIViewControllerTransitionsDelegate with some extra candy.
/// Basically the JellyAnimator is the main class to use when working with Jelly.
/// You need to create a JellyAnimator and assign it as a transitionDelegate to your ViewController.
/// After you did this you need to set the presentation style to custom so the VC asks its custom delegate.
/// You can use the prepare function for that

public class JellyAnimator : NSObject {
    
    fileprivate var presentation: JellyPresentation
    private weak var viewController : UIViewController?
    
    
    /// ## designated initializer
    /// - Parameter presentation: a custom Presentation Object
    public init(presentation: JellyPresentation) {
        self.presentation = presentation
        super.init()
    }
    
    /// ## prepare
    /// Call this function to prepare the viewController you want to present
    /// - Parameter viewController: viewController that should be presented in a custom way
    public func prepare(viewController: UIViewController) {
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
    }
}

/// ## UIViewControllerTransitioningDelegate Implementation
/// The JellyAnimator needs to conform to the UIViewControllerTransitioningDelegate protocol
/// it will provide a custom Presentation-Controller that tells UIKit which extra Views the presentation should have
/// it also provides the size and frame for the controller that wants to be presented
extension JellyAnimator: UIViewControllerTransitioningDelegate {
    
    
    /// Gets called from UIKit if presentatioStyle is custom and transitionDelegate is set
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let jellyPresentationController = JellyPresentationController(presentedViewController: presented, presentingViewController: presenting, presentation: presentation)
        return jellyPresentationController
    }
    
    /// Each Presentation has two directions
    /// Inside a Presention Object you can specify some extra parameters
    /// This Parameters will be passed to a custom animator that handles the presentation animation (duration, direction etc.)
    public func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            if let presentation = self.presentation as? JellySlideInPresentation {
                return JellySlideInPresentationAnimator(direction: presentation.directionShow, presentationType: .show, presentation: presentation)
            } else if let presentation = self.presentation as? JellyFadeInPresentation {
                return JellyFadeInPresentationAnimator(presentationType: .show, presentation: presentation)
            } else if let presentation = self.presentation as? JellyShiftInPresentation {
                return JellyShiftInPresentationAnimator(direction: presentation.direction, presentationType: .show, presentation: presentation)
            } else {
                return nil
            }
    }
    
    public func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            if let presentation = self.presentation as? JellySlideInPresentation {
                return JellySlideInPresentationAnimator(direction: presentation.directionDismiss, presentationType: .dismiss, presentation: presentation)
            } else if let presentation = self.presentation as? JellyFadeInPresentation {
                return JellyFadeInPresentationAnimator(presentationType: .dismiss, presentation: presentation)
            } else if let presentation = self.presentation as? JellyShiftInPresentation {
                return JellyShiftInPresentationAnimator(direction: presentation.direction, presentationType: .dismiss, presentation: presentation)
            } else {
                return nil
            }
    }
}
