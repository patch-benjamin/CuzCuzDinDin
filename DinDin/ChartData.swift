//
//  ChartData.swift
//  DinDin
//
//  Created by Ben Patch on 1/14/17.
//  Copyright © 2017 PatchWork. All rights reserved.
//

import Foundation

class ChartData: NSObject {
    
    static var Chart = ChartData();
    
    override init() {
        chartID = ChartData.loadChartID() ?? ""
        _isDownloaded = false
        self.name = ""
    }
    
    init(outerGroupItems: [String], innerGroupItems: [String], lastUpdated: Date, outerGroupStartingIndex: Int, chartID: String, name: String) {
        _isDownloaded = true
        self.name = name
        self.chartID = chartID
    }
    
    init?(outerGroupItemsDict: [String: AnyObject], innerGroupItemsDict: [String: AnyObject], lastUpdatedString: String, outerGroupStartingIndex: Int, chartID: String, name: String) {
        self.chartID = chartID
        self.name = name
        _isDownloaded = true
        
        // extract data and if unsuccessful, then:
        return nil
    }
    
    
    var chartID: String {
        willSet {
            ChartData.saveChartID(chartID: newValue)
        }
    }
    private var _isDownloaded: Bool
    var isDownloaded: Bool {
        get {
            return _isDownloaded
        }
    }
    var name: String
    var outerGroupItems = [String]()
    var innerGroupItems = [String]()
    var outerGroupStartingIndex = 0;
    var lastUpdated = Date()
    
    
    func saveToFirebase() {
        
    }
    
}

extension ChartData {
    static let chartIDKey = "chartID"
    
    class func saveChartID(chartID: String) {
        UserDefaults.standard.set(chartID, forKey: chartIDKey)
    }
    
    class func loadChartID() -> String? {
        return UserDefaults.standard.string(forKey: chartIDKey)
    }
}
