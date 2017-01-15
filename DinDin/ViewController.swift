//
//  ViewController.swift
//  DinnerRole
//
//  Created by Ben Patch on 1/7/17.
//  Copyright © 2017 PatchWork. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDinnnerHead()
        // check for chart id. if no chart id, then present the create chart view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // check for data in the ChartData
        // if data, then display it
        // if no data then present loading screan
        // check for chartID
        // if no chart id, then present create/download
        // if chartID, then download it
        // once downloaded and validated that there is data (same validation as step 1), dismiss loadingscreen
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        saveDinnnerHead()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var tableView: UITableView!

    static var dinnerActivities = ["Main Dish", "Side Dish", "Salad", "Dessert"]
    static var people = ["Karson & Kellie", "Hannah & Britney", "Ben & Kylee", "Elyse"]
    var dinnerHead = 0;
    
    static var dinnerHeadKey = "dinnerHead"
    
    func loadDinnnerHead(){
        let prefs = UserDefaults.standard
        
        dinnerHead = prefs.integer(forKey: ViewController.dinnerHeadKey)
    }
    
    func saveDinnnerHead()
    {
        let prefs = UserDefaults.standard
        prefs.setValue(dinnerHead, forKey: ViewController.dinnerHeadKey)
    }

    func incrementDinner()
    {
        dinnerHead += 1
        if (dinnerHead > 3)
        {
            dinnerHead = 0
        }
        saveDinnnerHead()
    }
    
    @IBAction func cycleListButtonTapped(_ sender: Any) {
        incrementDinner()
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    
    func getDinnerActvity(forRow row: Int) -> String {
        let dinnerActivities = ViewController.dinnerActivities
        var dinnerIndex = row + dinnerHead
        if dinnerIndex > 3
        {
            dinnerIndex -= 4
        }
        return dinnerActivities[dinnerIndex]
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") else { fatalError() }
        cell.textLabel?.text = ViewController.people[indexPath.row]
        cell.detailTextLabel?.text = getDinnerActvity(forRow: indexPath.row)
    
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
}
