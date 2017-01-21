//
//  ChartViewController.swift
//  DinDin
//
//  Created by Ben Patch on 1/16/17.
//  Copyright © 2017 PatchWork. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {

    // no chart: add button and no button top left
    // edit mode: done and cancel buttons top right
    // chart data: show data, show edit and action buttons.
    // loading: grayed out buttons and text saying the data is loading. Perhapse a spinner. no flag for this, simply when we start downloading, we setup the ui and when downloading finishes, we have a callback that reloads the tableview and fixes the ui to normal buttons.
    var chart = ChartData.Chart
    var chartExists: Bool {
        return chart.chartID != ""
    }
    var chartHasData: Bool {
        return chart.isDownloaded
   }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addEditBarButton: UIBarButtonItem!
    
    @IBOutlet weak var actionCancelBarButton: UIBarButtonItem!
    
    @IBAction func addEditBarButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func actionCancelBarButtonTapped(_ sender: Any) {
        
    }
    
    
}

extension ChartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            // handle add button tapped
            
        }
    }
}






