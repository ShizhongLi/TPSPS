//
//  ViewController.swift
//  TPSPS
//
//  Created by Mac Air TP05 on 2018/11/15.
//  Copyright © 2018 TP. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var pageController:MainPageController?
    
    @IBOutlet var mainContainerView: NSView!
    @IBOutlet weak var navView: NSView!
    
    @IBOutlet weak var patientInfoTabBtn: NSButton!
    @IBOutlet weak var similariPatientSearchTabBtn: NSButton!
    @IBOutlet weak var treatmentShowTabBtn: NSButton!
    
    @IBOutlet weak var mainFuncContainerView: NSView!
    @IBOutlet weak var patientInfoView: NSView!
    @IBOutlet weak var patientInfoTotalStackView: NSStackView!
    
    @IBOutlet weak var creatNewBtn: NSButton!
    @IBOutlet weak var importNewBtn: NSButton!
    @IBOutlet weak var ageTF: NSTextField!
    @IBOutlet weak var sexPUB: NSPopUpButton!
    @IBOutlet weak var birthDP: NSDatePicker!
    @IBOutlet weak var coDIseasePUB: NSPopUpButton!
    @IBOutlet weak var nonCoDiseasePUB: NSPopUpButton!
    @IBOutlet weak var ownDiseaseYearTF: NSTextField!
    
    @IBOutlet weak var symptomR1N1PastCB: NSButton!
    @IBOutlet weak var symptomR1N1RecentCB: NSButton!
    @IBOutlet weak var symptomR1N2PastCB: NSButton!
    @IBOutlet weak var symptomR1N2RecentCB: NSButton!
    @IBOutlet weak var symptomR1N3PastCB: NSButton!
    @IBOutlet weak var symptomR1N3RecentCB: NSButton!
    @IBOutlet weak var symptomR1N4PastCB: NSButton!
    @IBOutlet weak var symptomR1N4RecentCB: NSButton!
    @IBOutlet weak var symptomR1N5PastCB: NSButton!
    @IBOutlet weak var symptomR1N5RecentCB: NSButton!
    
    @IBOutlet weak var symptomR2N1CB: NSButton!
    @IBOutlet weak var symptomR2N2CB: NSButton!
    @IBOutlet weak var symptomR2N3CB: NSButton!
    @IBOutlet weak var symptomR2N4CB: NSButton!
    @IBOutlet weak var symptomR2N5CB: NSButton!
    @IBOutlet weak var symptomR2N6CB: NSButton!
    
    @IBOutlet weak var smokeHistoryPUB: NSPopUpButton!
    @IBOutlet weak var smokeHistoryYearTF: NSTextField!
    @IBOutlet weak var smokeMeasureNumTF: NSTextField!
    @IBOutlet weak var smokeMeasureUnitPUB: NSPopUpButton!
    @IBOutlet weak var smokeBaoNianTF: NSTextField!
    
    @IBOutlet weak var pastYearWorseCountTF: NSTextField!
    @IBOutlet weak var breathFuncExamPUB: NSPopUpButton!
    @IBOutlet weak var breathFuncMeasurePUB: NSPopUpButton!
    @IBOutlet weak var breathExam2PUB: NSPopUpButton!
    @IBOutlet weak var breathExam3PUB: NSPopUpButton!
    @IBOutlet weak var recentTreatmentPUB: NSPopUpButton!
    
//    var testView = NSView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.layer?.backgroundColor = NSColor.darkGray.cgColor
        
//        self.view.addSubview(testView)
//        testView.snp.makeConstraints { (make) -> Void in
//            make.width.height.equalTo(50)
//            make.center.equalTo(self.view)
//        }
        
    }
    
    override func viewDidAppear() {
        //TODO: 无效，暂时不知原因,从其他页面返回时有效
        navView!.layer?.backgroundColor = NSColor.blue.cgColor
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
//            self.navView?.layer?.backgroundColor = NSColor.green.cgColor
        }
    }
    
    
    @IBAction func clickImportNewBtn(_ sender: NSButton) {
        if self.pageController != nil {
            self.pageController?.selectedIndex = 1
        }
    }
    
    
}

