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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vc = createVC() {
            
            let presentation = JellyPresentation(jellyness: .jelly, duration: .medium, direction: .left, style: .slidein)
            let jellyAnimator = JellyAnimator(presentation:presentation)
            jellyAnimator.prepare(viewController: vc)
            
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

