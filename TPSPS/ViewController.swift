//
//  ViewController.swift
//  TPSPS
//
//  Created by Mac Air TP05 on 2018/11/15.
//  Copyright © 2018 TP. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var mainContainerView: NSView!
    @IBOutlet weak var navView: NSView!
    
    @IBOutlet weak var patientInfoTabBtn: NSButton!
    @IBOutlet weak var similariPatientSearchTabBtn: NSButton!
    @IBOutlet weak var treatmentShowTabBtn: NSButton!
    
    @IBOutlet weak var mainFuncContainerView: NSView!
    @IBOutlet weak var patientInfoView: NSView!
    @IBOutlet weak var patientInfoTotalStackView: NSStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
}

