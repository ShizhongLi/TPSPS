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
