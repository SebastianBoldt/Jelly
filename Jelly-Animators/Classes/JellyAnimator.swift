//
//  JellyAnimator.swift
//  Created by Sebastian Boldt on 17.11.16.
import UIKit

/**
 
 # JellyAnimator
 
 A JellyAnimator basically is an UIViewControllerTransitionsDelegate with some extra candy
 
 */

public class JellyAnimator : NSObject {
    
    fileprivate var presentation: JellyPresentation
    private weak var viewController : UIViewController?
    
    public init(presentation: JellyPresentation) {
        self.presentation = presentation
        super.init()
    }
    
    /// Call this function to prepare the viewController you want to present
    public func prepare(viewController: UIViewController) {
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
    }
}

/**
 # UIViewControllerTransitioningDelegate Implementation
 */
extension JellyAnimator: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let jellyPresentationController = JellyPresentationController(presentedViewController: presented, presentingViewController: presenting, presentation: presentation)
        return jellyPresentationController
    }
}
