//
//  MainPageController.swift
//  TPSPS
//
//  Created by Mac Air TP05 on 2018/11/20.
//  Copyright © 2018 TP. All rights reserved.
//

import Cocoa
import SwiftyJSON

class MainPageController: NSPageController, NSPageControllerDelegate {
    
    var localDataJSON: JSON?
    var currentPatientInfo: JSON?
    
    var mainVC: ViewController?
    var importPatientVC: ImportPatientVC?
    var searchSimilarPatientVC: SearchSimilarPatientVC?
    
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
            self.mainVC = self.storyboard?.instantiateController(withIdentifier: identifier) as? ViewController
            self.mainVC!.pageController = self
            return self.mainVC!
            
        } else if identifier == "ImportPatientVC" {
            self.importPatientVC = self.storyboard?.instantiateController(withIdentifier: identifier) as? ImportPatientVC
            self.importPatientVC!.pageController = self
            return self.importPatientVC!
            
        } else if identifier == "SearchSimilarPatientVC" {
            self.searchSimilarPatientVC = self.storyboard?.instantiateController(withIdentifier: identifier) as? SearchSimilarPatientVC
            self.searchSimilarPatientVC!.pageController = self
  
            self.searchSimilarPatientVC?.currentPatientInfo = self.currentPatientInfo
            self.searchSimilarPatientVC?.localDataJSON = self.localDataJSON
            
            return self.searchSimilarPatientVC!
            
        } else {
            return self.storyboard?.instantiateController(withIdentifier: identifier) as! NSViewController
        }

    }
    
}
