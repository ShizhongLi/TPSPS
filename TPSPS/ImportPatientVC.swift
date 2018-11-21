//
//  ImportPatientVC.swift
//  TPSPS
//
//  Created by Mac Air TP05 on 2018/11/20.
//  Copyright © 2018 TP. All rights reserved.
//

import Cocoa
import Python

class ImportPatientVC: NSViewController {
    
    var pageController:MainPageController?
    
//    let np = Python.impo
//    let a = np.arange(15).reshape(3, 5)
//    let b = np.array([6, 7, 8])
    
    @IBOutlet weak var patientID: NSTextField!
    @IBOutlet weak var patientInHospitalID: NSTextField!
    @IBOutlet weak var patientInfoSV: NSScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func clickBackBtn(_ sender: Any) {
        
        if (self.pageController != nil) {
            self.pageController?.selectedIndex = 0
        }
    }
    
    
    @IBAction func clickSearchByIDBtn(_ sender: Any) {
    }
    
    @IBAction func clickResetBtn(_ sender: NSButton) {
    }
    
    @IBAction func clickSearchSimilarPatientBtn(_ sender: NSButton) {
        
        if (self.pageController != nil) {
            self.pageController?.selectedIndex = 2
        }
    }
    
    
    
}
