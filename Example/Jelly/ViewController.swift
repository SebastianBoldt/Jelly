//
//  ViewController.swift
//  Jelly-Animators
//
//  Created by Sebastian Boldt on 11/16/2016.
//  Copyright (c) 2016 Sebastian Boldt. All rights reserved.
//
import UIKit
import Jelly

struct DataObject {
    var presentation : JellyPresentation
    var titleDescription : String
    var detailDescription : String
}

class ViewController: UIViewController {

    fileprivate lazy var model : [DataObject] = {
        var data : [DataObject] = [DataObject]()
        
        let defaultSlideInPresentation = DataObject(presentation: JellySlideInPresentation(widthForViewController: .halfscreen, heightForViewController: .halfscreen), titleDescription: "Default Slide in Animation", detailDescription: "default values")
        let defaultFadeInPresentation = DataObject(presentation: JellyFadeInPresentation(widthForViewController: .halfscreen, heightForViewController: .halfscreen), titleDescription: "Default Fade in Animation", detailDescription: "default values")
        
        let customBlurFadeIn = DataObject(presentation: JellyFadeInPresentation(backgroundStyle: .blur(effectStyle: .light),widthForViewController: .halfscreen, heightForViewController: .halfscreen), titleDescription: "Blurred Fade in", detailDescription: "blurred  background .light")
        
        let customBlurSlideIn = DataObject(presentation: JellySlideInPresentation(backgroundStyle: .blur(effectStyle: .dark),widthForViewController: .halfscreen, heightForViewController: .halfscreen), titleDescription: "Blurred Slide in", detailDescription: "blurred background .dark")
        
        let customCornerDirectionSlideIn = DataObject(presentation: JellySlideInPresentation(cornerRadius: 15,backgroundStyle: .blur(effectStyle: .dark), jellyness: .jellier, duration: .medium, directionShow: .left, directionDismiss: .right,widthForViewController: .halfscreen, heightForViewController: .halfscreen), titleDescription: "Blurred Slide in Custom Direction", detailDescription: "custom corner radius, directions and jelliness")
        
        let present = JellySlideInPresentation(dismissCurve: .linear, presentationCurve: .linear, cornerRadius: 0, backgroundStyle: .dimmed, jellyness: .none, duration: .normal, directionShow: .left, directionDismiss: .left, widthForViewController: .halfscreen, heightForViewController: .fullscreen, horizontalAlignment: .left, verticalAlignment: .top)
        let slideOver = DataObject(presentation: present, titleDescription: "SlideOver", detailDescription: "Yes")
        
        // Custom Alert 
        
        let alertPresentation = JellySlideInPresentation(dismissCurve: .linear, presentationCurve: .linear, cornerRadius: 15, backgroundStyle: .blur(effectStyle: .light), jellyness: .jellier, duration: .normal, directionShow: .top, directionDismiss: .top, widthForViewController: .fullscreen, heightForViewController: .custom(value: 100) , horizontalAlignment: .center, verticalAlignment: .top, marginGuards: UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10))
        let alert = DataObject(presentation: alertPresentation, titleDescription: "Custom Alert", detailDescription: "Custom Alert")
        
        data.append(defaultFadeInPresentation)
        data.append(defaultSlideInPresentation)
        data.append(customBlurFadeIn)
        data.append(customBlurSlideIn)
        data.append(customCornerDirectionSlideIn)
        data.append(slideOver)
        data.append(alert)
        
        return data
    }()
    
    @IBOutlet var presentMeButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    fileprivate var jellyAnimator: JellyAnimator? // We need to keep a strong reference to the Animator because the transitiong delegate is weak
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func createVC() -> UIViewController? {
        return self.storyboard?.instantiateViewController(withIdentifier: "PresentMe")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = self.createVC() {
            let presentation = self.model[indexPath.row].presentation
            self.jellyAnimator = JellyAnimator(presentation:presentation)
            self.jellyAnimator?.prepare(viewController: viewController)
            self.present(viewController, animated: true, completion: nil)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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

