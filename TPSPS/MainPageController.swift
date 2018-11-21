//
//  MainPageController.swift
//  TPSPS
//
//  Created by Mac Air TP05 on 2018/11/20.
//  Copyright © 2018 TP. All rights reserved.
//

import Cocoa

class MainPageController: NSPageController, NSPageControllerDelegate {
    
    var orderedViewControllers: [NSViewController] = {
        return [NSStoryboard(name: "Main", bundle:nil).instantiateController(withIdentifier: "InitVC") as! NSViewController,
                NSStoryboard(name: "Main", bundle:nil).instantiateController(withIdentifier: "ImportPatientVC") as! NSViewController,
                NSStoryboard(name: "Main", bundle:nil).instantiateController(withIdentifier: "SearchSimilarPatientVC") as! NSViewController
                ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        delegate = self
        self.arrangedObjects = orderedViewControllers
    }
    
    func pageController(_ pageController: NSPageController, identifierFor object: Any) -> String {

        switch(self.selectedIndex)
        {
        case 0 :
            return "InitVC"
        case 1 :
            return "ImportPatientVC"
        case 2:
            return "SearchSimilarPatientVC"
        default :
            return "InitVC"
        }
    }
    
    func pageController(_ pageController: NSPageController, viewControllerForIdentifier identifier: String) -> NSViewController {
        
        if identifier == "InitVC" {
            let vc = self.storyboard?.instantiateController(withIdentifier: identifier) as! ViewController
            vc.pageController = self
            return vc
            
        } else if identifier == "ImportPatientVC" {
            let vc = self.storyboard?.instantiateController(withIdentifier: identifier) as! ImportPatientVC
            vc.pageController = self
            return vc
            
        } else if identifier == "SearchSimilarPatientVC" {
            let vc = self.storyboard?.instantiateController(withIdentifier: identifier) as! SearchSimilarPatientVC
            vc.pageController = self
            return vc
            
        } else {
            return self.storyboard?.instantiateController(withIdentifier: identifier) as! NSViewController
        }

    }
    
}
