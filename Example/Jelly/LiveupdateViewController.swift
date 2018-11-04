//
//  LiveupdateViewController.swift
//  Jelly_Example
//
//  Created by Sebastian Boldt on 04.11.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

import UIKit
import Jelly

class LiveupdateViewController: UIViewController {
    var animator: Animator?
    var viewControllerToPresent: UIViewController?
    
    @IBAction func didPressShowButton(_ sender: Any) {
        present(viewControllerToPresent!, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            //self.animator?.updateHeight(height: .fullscreen, duration: .medium)
            try! self.animator?.updateAlignment(alignment: PresentationAlignment(vertical: .bottom, horizontal: .center), duration: .medium)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 20, backgroundStyle: .blurred(effectStyle: .dark), isTapBackgroundToDismissEnabled: true)
        let size = PresentationSize(width: .fullscreen, height: .custom(value: 300))
        let interaction = InteractionConfiguration(presentingViewController: self, completionThreshold: 0.5, dragMode: .canvas)
        let alignment = PresentationAlignment(vertical: .top, horizontal: .center)
        let presentation = CoverPresentation(directionShow: .top,
                                             directionDismiss: .top,
                                             uiConfiguration: uiConfiguration,
                                             size: size,
                                             alignment: alignment,
                                             marginGuards: UIEdgeInsets(top: 120, left: 16, bottom: 120, right: 16),
                                             interactionConfiguration: interaction)
        let animator = Animator(presentation: presentation)
        viewControllerToPresent = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PresentMe")
        animator.prepare(presentedViewController: viewControllerToPresent!)
        self.animator = animator
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
