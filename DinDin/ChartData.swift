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
    
    
    var chartID: String = ""
    var outerGroupItems = [String]()
    var innerGroupItems = [String]()
    var outerGroupStartingIndex = 0;
    var lastUpdated = Date()
    
    
    func saveToFirebase() {
        
    }
    
}
