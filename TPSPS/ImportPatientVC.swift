//
//  ImportPatientVC.swift
//  TPSPS
//
//  Created by Mac Air TP05 on 2018/11/20.
//  Copyright © 2018 TP. All rights reserved.
//

import Cocoa

class ImportPatientVC: NSViewController {
    
    var pageController:MainPageController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        if (self.pageController != nil) {
            self.pageController?.selectedIndex = 0
        }
    }
}
