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
            try! self.animator?.updateSize(presentationSize: PresentationSize(width: .fullscreen, height: .fullscreen), duration: .medium)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
        let uiConfiguration = PresentationUIConfiguration(cornerRadius: 30, backgroundStyle: .dimmed(alpha: 0.5), isTapBackgroundToDismissEnabled: true)
        let size = PresentationSize(width: .halfscreen, height: .halfscreen)
        let interaction = InteractionConfiguration(presentingViewController: self, completionThreshold: 0.5, dragMode: .canvas)
        let alignment = PresentationAlignment(vertical: .top, horizontal: .left)
        let presentation = CoverPresentation(directionShow: .top,
                                             directionDismiss: .top,
                                             uiConfiguration: uiConfiguration,
                                             size: size,
                                             alignment: alignment,
                                             marginGuards: UIEdgeInsets(top: 60, left: 16, bottom: 40, right: 16),
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
