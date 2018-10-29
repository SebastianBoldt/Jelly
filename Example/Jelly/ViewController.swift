//
//  ViewController.swift
//  Jelly-Animators
//
//  Created by Sebastian Boldt on 11/16/2016.
//  Copyright (c) 2016 Sebastian Boldt. All rights reserved.
//
import UIKit
import Jelly

class ViewController: UIViewController {

    fileprivate lazy var model : [DataObject] = {
        return ExampleDataProvider().data
    }()
    
    @IBOutlet var presentMeButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    /// We need to keep a strong reference to the Animator because the transitiong delegate is weak
    fileprivate var animator: Jelly.Animator?
    
    fileprivate func createVC() -> UIViewController? {
        return self.storyboard?.instantiateViewController(withIdentifier: "PresentMe")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presentation = self.model[indexPath.row].presentation
        if let viewController = self.createVC() {
            self.animator = Jelly.Animator(presentation:presentation)
            self.animator?.prepare(viewController: viewController)
            self.present(viewController, animated: true, completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
            var presentation = Jelly.SlideInPresentation()
            self.animator?.resizePresentedViewController(using: presentation)
        })
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let data = model[indexPath.row]
        cell.textLabel?.text = data.titleDescription
        cell.detailTextLabel?.text = data.detailDescription
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
