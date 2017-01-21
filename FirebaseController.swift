//
//  FirebaseController.swift
//  DinDin
//
//  Created by Ben Patch on 1/21/17.
//  Copyright © 2017 PatchWork. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class FirebaseController {
    static var ref = FIRDatabase.database().reference()
    
    static let chartsUrl = ref.child("charts").child(chartID!)
    static let outerGroupsUrl = ref.child("outerGroups").child(chartID!)
    static let innerGroupsUrl = ref.child("innerGroups").child(chartID!)
    static let lastUpdatedUrl = ref.child("lastUpdated").child(chartID!)
    static let outerGroupsStartingIndexUrl = ref.child("outerGroupStartingIndex").child(chartID!)
    
    static var chartID: String? {
        let id = ChartData.Chart.chartID
        return id == "" ? nil : id
    }
    
    static func getNewChartID(chartName: String) -> String {
        let id: String = ref.child("charts").key
        return id
    }
    
    
    class func downloadChart(chartID: String, completion: @escaping ()->()) {
        var name = ""
        var outerGroups = [String]()
        var innerGroups = [String]()
        var lastUpdated = Date()
        var startingIndex = 0
        
        let group = DispatchGroup()
        
        // load the chartName
        group.enter()
        chartsUrl.observe(.value, with: { (snap) in
            name = snap.value as? String ?? ""
            
            group.leave()
        })
        
        // load the outer groups
        group.enter()
        outerGroupsUrl.observe(.value, with: { (snap) in
            outerGroups = snap.value as? [String] ?? [String]()
            
            group.leave()
        })
        
        // load the inner groups
        group.enter()
        innerGroupsUrl.observe(.value, with: { (snap) in
            innerGroups = snap.value as? [String] ?? [String]()
            
            group.leave()
        })
        
        // load the last updated date
        group.enter()
        lastUpdatedUrl.observe(.value, with: { (snap) in
            let lastUpdatedString = snap.value as? String ?? ""
            lastUpdated = Date.formatter.date(from: lastUpdatedString) ?? Date()
            
            group.leave()
        })
        
        // load the starting index
        group.enter()
        outerGroupsStartingIndexUrl.observe(.value, with: { (snap) in
            startingIndex = snap.value as? Int ?? 0
            
            group.leave()
        })

        
        group.notify(queue: DispatchQueue.main) {
            // update the chart
            ChartData.Chart = ChartData(outerGroupItems: outerGroups, innerGroupItems: innerGroups, lastUpdated: lastUpdated, outerGroupStartingIndex: startingIndex, chartID: chartID, name: name)
            
            completion()
        }
    }
    
    class func saveChartSuccessfully() {
        guard ChartData.Chart.isDownloaded else {
            // nothing to save
            return
        }
        
        //save the outergroups
        let outerGroups = ChartData.Chart.outerGroupItems
        outerGroupsUrl.setValue(outerGroups)
        
        //save the inner groups
        let innerGroups = ChartData.Chart.innerGroupItems
        innerGroupsUrl.setValue(innerGroups)
        
        //save the chartName?
        let name = ChartData.Chart.name
        chartsUrl.setValue(name)
        
        //save the last updated
        let lastUpdatedString = Date.formatter.string(from: ChartData.Chart.lastUpdated)
        lastUpdatedUrl.setValue(lastUpdatedString)
        
        //save the starting index
        let startingIndex = ChartData.Chart.outerGroupStartingIndex
        outerGroupsStartingIndexUrl.setValue(startingIndex)
    }
    
}
