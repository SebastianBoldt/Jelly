//
//  ViewController.swift
//  Jelly-Animators
//
//  Created by Sebastian Boldt on 11/16/2016.
//  Copyright (c) 2016 Sebastian Boldt. All rights reserved.
//
import UIKit
import Jelly

class MenuViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainVC = segue.destination as? MainViewController else {
            return
        }
        
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
            // Not Interactive
            case "NotInteractive-coverFromLeft":
                mainVC.type = ExampleType.nonInteractive(type: .coverFromBottom)
            case "NotInteractive-slideFromLeft":
                mainVC.type = ExampleType.nonInteractive(type: .slideFromRight)
            
            // Interactive
            case "Interactive-CoverMenuFromRightCanvas":
                mainVC.type = ExampleType.interactive(type: .coverMenuFromRightCanvas)
            case "Interactive-SlideMenuFromRightEdge":
                mainVC.type = ExampleType.interactive(type: .slideMenuFromRightEdge)
            case "Interactive-NotificationFromTopCanvas":
                mainVC.type = ExampleType.interactive(type: .notificationFromTopCanvas)
            case "Interactive-MultipleDirectionCoverCanvas":
                mainVC.type = ExampleType.interactive(type: .multipleDirectionsCoverCanvas)
            
            // Live Update
            case "LiveUpdate-Size":
                mainVC.type = ExampleType.liveUpdate(type: .updateSize)
            case "LiveUpdate-Alignments":
                mainVC.type = ExampleType.liveUpdate(type: .updateAlignment)
            case "LiveUpdate-MarginGuards":
                mainVC.type = ExampleType.liveUpdate(type: .updateMarginGuards)
            case "LiveUpdate-CornerRadius":
                mainVC.type = ExampleType.liveUpdate(type: .updateCornerRadius)
            default:()
        }
    }
}
