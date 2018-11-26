//
//  ImportPatientVC.swift
//  TPSPS
//
//  Created by Mac Air TP05 on 2018/11/20.
//  Copyright © 2018 TP. All rights reserved.
//

import Cocoa
import SwiftyJSON

class ImportPatientVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    var localDataJSON: JSON?
    var currentPatientInfo: JSON?
    
    var pageController:MainPageController?
    
    @IBOutlet weak var patientID: NSTextField!
    @IBOutlet weak var patientInHospitalID: NSTextField!
    @IBOutlet weak var patientInfoSV: NSScrollView!
    @IBOutlet weak var patientInfoTV: NSTableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.patientInfoTV.delegate = self
        self.patientInfoTV.dataSource = self
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
            
            let answer = dialogOKCancel(question: "您是否未输入患者住院ID?", text: "请输入患者住院ID来查询该患者信息")
            
        } else {
            if self.localDataJSON == nil {
                return
            }
            
            var foundPatient = false
            let localDataCount = localDataJSON!["data"].count
            let tempData = localDataJSON!["data"]
            for i in 0..<localDataCount {
                if tempData[i][0].string == self.patientInHospitalID.stringValue {
                    foundPatient = true
                    self.currentPatientInfo = tempData[i]
                    self.patientInfoTV.reloadData()
                    break
                }
            }
            
            if foundPatient == false {
                func dialogOKCancel(question: String, text: String) -> Bool {
                    let myPopup: NSAlert = NSAlert()
                    myPopup.messageText = question
                    myPopup.informativeText = text
                    myPopup.alertStyle = NSAlert.Style.informational
                    myPopup.addButton(withTitle: "好的")
                    return myPopup.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn
                }
                let answer = dialogOKCancel(question: "本地数据库未找到该住院ID的b患者信息", text: "")
            }
            
        }
        
    }
    
    @IBAction func clickResetBtn(_ sender: NSButton) {
        self.patientID.stringValue = ""
        self.patientInHospitalID.stringValue = ""
        self.currentPatientInfo = nil
        self.patientInfoTV.reloadData()
    }
    
    @IBAction func clickSearchSimilarPatientBtn(_ sender: NSButton) {
        
        if self.currentPatientInfo == nil {
            func dialogOKCancel(question: String, text: String) -> Bool {
                let myPopup: NSAlert = NSAlert()
                myPopup.messageText = question
                myPopup.informativeText = text
                myPopup.alertStyle = NSAlert.Style.informational
                myPopup.addButton(withTitle: "好的")
                return myPopup.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn
            }
            let answer = dialogOKCancel(question: "您当前未指定任何患者作为查询相似患者的参考", text: "请先输入患者住院ID并在本页面查询到患者详情后，再进行相似患者查找")
            
            return
        }
        
        if (self.pageController != nil) {
            self.pageController?.currentPatientInfo = self.currentPatientInfo
            self.pageController?.localDataJSON = self.localDataJSON
            
            self.pageController?.selectedIndex = 2
        }
    }
    
    func testReadJSON() {
        let path = Bundle.main.path(forResource: "patientInfo_new", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
//        var json: JSON = JSON()
        do {
            self.localDataJSON = try JSON(data:jsonData! as Data)
        } catch {
        
        }
//        print(localDataJSON!["data"].count)
//        print(localDataJSON!["data"][0].count)
//        print(localDataJSON!["columns"])
//        print(localDataJSON!["index"])
    }
    
    //MARK:- --NSTableView DataSource & Delegate
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.currentPatientInfo == nil ? 0 : (self.currentPatientInfo?.count ?? 0)
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        //获取表格列的标识符
        let columnID = tableColumn?.identifier
    
        var strIdt = "PatientInfoAttrNameCellView"
        if columnID!.rawValue == "PatientInfoAttrNameColumn" {
            strIdt = "PatientInfoAttrNameCellView"
        } else if columnID!.rawValue == "PatientInfoAttrValueColumn" {
            strIdt = "PatientInfoAttrValueCellView"
        }

        let cell: NSTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: strIdt), owner: self) as! NSTableCellView
    
        cell.wantsLayer = true

        if columnID!.rawValue == "PatientInfoAttrNameColumn" {
            cell.layer?.backgroundColor = NSColor.blue.cgColor
            cell.textField?.stringValue = self.localDataJSON?["columns"][row].string ?? "无"
            
        } else if columnID!.rawValue == "PatientInfoAttrValueColumn" {
            cell.layer?.backgroundColor = NSColor.orange.cgColor
            cell.textField?.stringValue = self.currentPatientInfo?[row].string ?? "无"
        }
        
    
        return cell;

    }
    
    
}
