//
//  SearchSimilarPatientVC.swift
//  TPSPS
//
//  Created by Mac Air TP05 on 2018/11/21.
//  Copyright © 2018 TP. All rights reserved.
//

import Cocoa
import SwiftyJSON
import Alamofire

class SearchSimilarPatientVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    var pageController:MainPageController?
    
    var localDataJSON: JSON?
    var currentPatientInfo: JSON?
    var similarPatient1Info: JSON?
    var similarPatient2Info: JSON?
    var similarPatient3Info: JSON?
    var similarPatientResultJSON: JSON?
    
    static let sharedSessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    @IBOutlet weak var patientInfoTV: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.patientInfoTV.delegate = self
        self.patientInfoTV.dataSource = self
    }
    override func viewDidAppear() {
        if self.currentPatientInfo != nil {
            
            func dialogOKCancel(question: String, text: String) -> Bool {
                let myPopup: NSAlert = NSAlert()
                myPopup.messageText = question
                myPopup.informativeText = text
                myPopup.alertStyle = NSAlert.Style.warning
                myPopup.addButton(withTitle: "开始查找")
                myPopup.addButton(withTitle: "取消")
                return myPopup.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn
            }
            let answer = dialogOKCancel(question: "即将开始相似患者查找", text: "由于数据量较大，查找过程可能会花费大约1分30秒，完成搜索后会有信息提示，请您耐心等待...是否开始？")
            
            if answer == false {
                return
            }
            
            let inpatientID = self.currentPatientInfo![0].string!
            SearchSimilarPatientVC.sharedSessionManager.request("http://192.168.0.162:8080/similarpatient/\(inpatientID)").responseJSON { response in //similarpatient/\(inpatientID)
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
 
                }
                
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                    self.similarPatientResultJSON = JSON(data)
                    self.getFullInfoOfSimilarPatients(result: self.similarPatientResultJSON)
                    
                } else {
                    func dialogOKCancel01(question: String, text: String) -> Bool {
                        let myPopup: NSAlert = NSAlert()
                        myPopup.messageText = question
                        myPopup.informativeText = text
                        myPopup.alertStyle = NSAlert.Style.warning
                        myPopup.addButton(withTitle: "好的")
                        return myPopup.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn
                    }
                    let answer = dialogOKCancel01(question: "未找到该患者的相似患者", text: "")
                }
                
            }
        }
        
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
    
    func getFullInfoOfSimilarPatients(result: JSON?) {
        if result == nil || result == JSON() {
            func dialogOKCancel01(question: String, text: String) -> Bool {
                let myPopup: NSAlert = NSAlert()
                myPopup.messageText = question
                myPopup.informativeText = text
                myPopup.alertStyle = NSAlert.Style.warning
                myPopup.addButton(withTitle: "好的")
                return myPopup.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn
            }
            let answer = dialogOKCancel01(question: "未找到该患者的相似患者", text: "")
            
        } else {
//            var patient1id = result[0].key
            var keys = [String]()
            var foundNum = 0
            for (key,subJson):(String,JSON) in result! {
                print("\(key)：\(subJson)")
                keys.append(key)
            }
            
            let localDataCount = localDataJSON!["data"].count
            let tempData = localDataJSON!["data"]
            for i in 0..<localDataCount {
                if keys.contains(tempData[i][0].string!) {
                    foundNum += 1
                    switch foundNum {
                    case 1:
                        self.similarPatient1Info = tempData[i]
                    case 2:
                        self.similarPatient2Info = tempData[i]
                    case 3:
                        self.similarPatient3Info = tempData[i]
                    default:
                        break
                    }
                
                    if foundNum >= keys.count {
                        break
                    }
                }
            }
            self.patientInfoTV.reloadData()
            
            
            func dialogOKCancel02(question: String, text: String) -> Bool {
                let myPopup: NSAlert = NSAlert()
                myPopup.messageText = question
                myPopup.informativeText = text
                myPopup.alertStyle = NSAlert.Style.warning
                myPopup.addButton(withTitle: "好的")
                return myPopup.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn
            }
            let answer = dialogOKCancel02(question: "已找到该患者的相似患者", text: "")
        }
        
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
        } else if columnID!.rawValue == "Similar1Column" {
            strIdt = "Similar1Cell"
        } else if columnID!.rawValue == "Similar2Column" {
            strIdt = "Similar2Cell"
        } else if columnID!.rawValue == "Similar3Column" {
            strIdt = "Similar3Cell"
        }
        
        let cell: NSTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: strIdt), owner: self) as! NSTableCellView
        
        cell.wantsLayer = true
        
        if columnID!.rawValue == "PatientInfoAttrNameColumn" {
            cell.layer?.backgroundColor = NSColor.blue.cgColor
            cell.textField?.stringValue = self.localDataJSON?["columns"][row].string ?? "无"
            
        } else if columnID!.rawValue == "PatientInfoAttrValueColumn" {
            cell.layer?.backgroundColor = NSColor.orange.cgColor
            cell.textField?.stringValue = self.currentPatientInfo?[row].string ?? "无"
            
        } else if columnID!.rawValue == "Similar1Column" {
            cell.layer?.backgroundColor = NSColor.purple.cgColor
            
            if self.similarPatient1Info != nil {
                cell.textField?.stringValue = self.similarPatient1Info?[row].string ?? "无"
            }
            
        } else if columnID!.rawValue == "Similar2Column" {
            cell.layer?.backgroundColor = NSColor.orange.cgColor
            
            if self.similarPatient2Info != nil {
                cell.textField?.stringValue = self.similarPatient2Info?[row].string ?? "无"
            }
        } else if columnID!.rawValue == "Similar3Column" {
            cell.layer?.backgroundColor = NSColor.purple.cgColor
            if self.similarPatient3Info != nil {
                cell.textField?.stringValue = self.similarPatient3Info?[row].string ?? "无"
            }
        }
        
        
        return cell;
        
    }
    
}
