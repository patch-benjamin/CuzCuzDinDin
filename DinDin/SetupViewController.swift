//
//  SetupViewController.swift
//  DinDin
//
//  Created by Ben Patch on 1/14/17.
//  Copyright © 2017 PatchWork. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SwitcherChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // new chart
            updateUIForNewChart()
        } else {
            // enter code
            updateUIForEnterCode()
        }
        isNewChartMode = sender.selectedSegmentIndex == 0
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let text = groupNumberTextFiled.text, text != "" else {
            // validate text has been entered.
            let message = "Must enter " + (isNewChartMode ? "number of groups" : "a chart code")
            let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            // if they enter an invalid chart code
            // stop the create button from being tapped or the enter button from being tapped if there is invalid text
            return
        }
        
        if isNewChartMode {
            // start segue
            performSegue(withIdentifier: "showSetupTableViewController", sender: self)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var groupNumberTextFiled: UITextField!
    @IBOutlet weak var nextButton: UIButton!
   
    var isNewChartMode = true;
    
    func updateUIForNewChart() {
        TitleLabel.text = "Number of groups in your chart:"
        groupNumberTextFiled.text = ""
        groupNumberTextFiled.placeholder = "i.e. 5"
        groupNumberTextFiled.keyboardType = .numberPad
        nextButton.setTitle("Create!", for: UIControlState.normal)
    }
    
    func updateUIForEnterCode() {
        TitleLabel.text = "Enter chart code:"
        groupNumberTextFiled.text = ""
        groupNumberTextFiled.placeholder = "i.e. 12kj3kl3j21lklf"
        groupNumberTextFiled.keyboardType = .default
        nextButton.setTitle("Continue", for: UIControlState.normal)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let setupGroupsController = segue.destination as? SetupGroupsTableViewController else { fatalError() }
        
        setupGroupsController.numberOfGroups = Int(groupNumberTextFiled.text!)!
    }
    
}




