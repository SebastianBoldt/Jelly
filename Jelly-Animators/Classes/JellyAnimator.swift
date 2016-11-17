//
//  JellyAnimator.swift
//  Created by Sebastian Boldt on 17.11.16.
import UIKit

/**
 # JellyAnimator
 
 A JellyAnimator basically is an UIViewControllerTransitionsDelegate with some extra candy
 
 */

public class JellyAnimator : NSObject {
    
    private var jellyness : JellyConstants.Jellyness = .jellier
    private var duration : JellyConstants.Duration = .medium
    private var direction : JellyConstants.Direction = .top
    private var style : JellyConstants.Style = .slidein
    
    private weak var viewController : UIViewController?
    
    public init(presentation: JellyPresentation) {
        
        self.jellyness = presentation.jellyness
        self.duration = presentation.duration
        self.direction = presentation.direction
        self.style = presentation.style
        super.init()
    }
    
    public func prepare(viewController: UIViewController) {
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
    }
}

/**
 # UIViewControllerTransitioningDelegate Implementation
 */
extension JellyAnimator: UIViewControllerTransitioningDelegate {
    
}
