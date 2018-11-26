//
//  SearchSimilarPatientVC.swift
//  TPSPS
//
//  Created by Mac Air TP05 on 2018/11/21.
//  Copyright © 2018 TP. All rights reserved.
//

import Cocoa
import SwiftyJSON

class SearchSimilarPatientVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    var pageController:MainPageController?
    
    var localDataJSON: JSON?
    var currentPatientInfo: JSON?
    
    @IBOutlet weak var patientInfoTV: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.patientInfoTV.delegate = self
        self.patientInfoTV.dataSource = self
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
