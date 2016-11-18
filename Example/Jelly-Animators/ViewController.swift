//
//  ViewController.swift
//  Jelly-Animators
//
//  Created by Sebastian Boldt on 11/16/2016.
//  Copyright (c) 2016 Sebastian Boldt. All rights reserved.
//
import UIKit
import Jelly_Animators

class ViewController: UIViewController {

    @IBOutlet var presentMeButton: UIButton!
    private var jellyAnimator: JellyAnimator? // We need to keep a string reference to the Animator because the transitiong delegate is weak
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func presentMeButtonPressed(_ sender: Any) {
        if let viewController = createVC() {
            
            let finalSize = CGSize(width: 200, height: 500)
            let presentation = JellyPresentation(jellyness: .jelly,
                                                 duration: .ultraSlow,
                                                 directionShow: .left,
                                                 directionDismiss: .top,
                                                 style: .slidein,
                                                 curve: .EaseInEaseOut,
                                                 sizeForViewController: finalSize,
                                                 showDimmingView: false,
                                                 cornerRadius: 10)
            
            self.jellyAnimator = JellyAnimator(presentation:presentation)
            self.jellyAnimator?.prepare(viewController: viewController)
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    
    private func createVC() -> UIViewController? {
        return self.storyboard?.instantiateViewController(withIdentifier: "PresentMe")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

