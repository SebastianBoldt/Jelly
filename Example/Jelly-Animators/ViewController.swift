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
        if let vc = createVC() {
            
            let finalSize = CGSize(width: 200, height: 200)
            let presentation = JellyPresentation(jellyness: .jelly,
                                                 duration: .medium,
                                                 direction: .left, style: .slidein,
                                                 sizeForViewController: finalSize,
                                                 showDimmingView: true,
                                                 cornerRadius: 40)
            
            self.jellyAnimator = JellyAnimator(presentation:presentation)
            self.jellyAnimator?.prepare(viewController: vc)
            self.present(vc, animated: true, completion: nil)
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

