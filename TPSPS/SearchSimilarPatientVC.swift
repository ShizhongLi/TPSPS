//
//  SearchSimilarPatientVC.swift
//  TPSPS
//
//  Created by Mac Air TP05 on 2018/11/21.
//  Copyright © 2018 TP. All rights reserved.
//

import Cocoa

class SearchSimilarPatientVC: NSViewController {
    
    var pageController:MainPageController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func clickBackBtn(_ sender: NSButton) {
        if (self.pageController != nil) {
            self.pageController?.selectedIndex = 1
        }
    }
    
    @IBAction func clickBackToHomeBtn(_ sender: NSButton) {
        if (self.pageController != nil) {
            self.pageController?.selectedIndex = 0
        }
    }
    
}
