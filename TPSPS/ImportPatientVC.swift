//
//  ImportPatientVC.swift
//  TPSPS
//
//  Created by Mac Air TP05 on 2018/11/20.
//  Copyright © 2018 TP. All rights reserved.
//

import Cocoa
import SwiftyJSON

class ImportPatientVC: NSViewController {
    
    var pageController:MainPageController?
    
    @IBOutlet weak var patientID: NSTextField!
    @IBOutlet weak var patientInHospitalID: NSTextField!
    @IBOutlet weak var patientInfoSV: NSScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        testReadJSON()
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
    
    func testReadJSON() {
        let path = Bundle.main.path(forResource: "patientInfo", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        var json: JSON = JSON()
        do {
            json = try JSON(data:jsonData! as Data)
        } catch {
        
        }
        
        print("Json Count:" + String(json.count))
        print(json[0])
    }
    
    
}
