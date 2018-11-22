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
    
    var localDataJSON: JSON?
    var currentPatientInfo: JSON?
    
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
        
        if self.patientInHospitalID.stringValue == "" {
            func dialogOKCancel(question: String, text: String) -> Bool {
                let myPopup: NSAlert = NSAlert()
                myPopup.messageText = question
                myPopup.informativeText = text
                myPopup.alertStyle = NSAlert.Style.warning
                myPopup.addButton(withTitle: "好的")
                myPopup.addButton(withTitle: "取消")
                return myPopup.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn
            }
            
            let answer = dialogOKCancel(question: "您是否未输入患者住院ID?", text: "未输入则无法查找")
            print(answer)
            
        } else {
            for patientInfo in localDataJSON!["data"] {
//                if (patientInfo as JSON)[0] == self.patientInHospitalID.stringValue {
//                    self.currentPatientInfo = patientInfo
//                    print(self.currentPatientInfo)
//
//                } else {
//
//                }
            }
            
        }
        
    }
    
    @IBAction func clickResetBtn(_ sender: NSButton) {
    }
    
    @IBAction func clickSearchSimilarPatientBtn(_ sender: NSButton) {
        
        if (self.pageController != nil) {
            self.pageController?.selectedIndex = 2
        }
    }
    
    func testReadJSON() {
        let path = Bundle.main.path(forResource: "patientInfo_new", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
//        var json: JSON = JSON()
        do {
            localDataJSON = try JSON(data:jsonData! as Data)
        } catch {
        
        }
        print(localDataJSON!["data"].count)
        print(localDataJSON!["data"][0].count)
        print(localDataJSON!["columns"])
        print(localDataJSON!["index"])
    }
    
    
}
