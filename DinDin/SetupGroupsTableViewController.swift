//
//  SetupGroupsTableViewController.swift
//  DinDin
//
//  Created by Ben Patch on 1/14/17.
//  Copyright © 2017 PatchWork. All rights reserved.
//

import UIKit

class SetupGroupsTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    @IBAction func nextButtonTapped(_ sender: Any) {
    
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        //pop up alert to ask if they are sure.
        if (innerItems.count + outerItems.count) <= 0 {
            // no items, don't warn
            dismiss(animated: true, completion: nil)
            return
        }
        
        let alert = UIAlertController(title: "Are you sure?", message: "Canceling will lose all entered data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "I'm sure", style: .default, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    var numberOfGroups = 0
    var innerItems = [Int : String]()
    var outerItems = [Int : String]()
    var isInnerItemsMode = true
    
    var items: [Int : String] {
        return isInnerItemsMode ? innerItems : outerItems
    }
    
    
    func isLastRow(row: Int) -> Bool {
        return row == numberOfGroups - 1
    }
    
    func editNextRow(lastRow: Int) {
        let indexPath = IndexPath(item: lastRow, section: 0)
        tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? TextFieldTableViewCell else { fatalError() }
        cell.textField.becomeFirstResponder()
    }
    
    func getRowsWithInvalidText() -> [Int] {
        var invalidRows = [Int]()
        items.forEach { (keyValue) in
            if keyValue.value == "" {
                invalidRows.append(keyValue.key)
            }
        }
        if items.count < numberOfGroups {
            for i in 0..<numberOfGroups {
                if items[i] == nil {
                    invalidRows.append(i)
                }
            }
        }
        
        return invalidRows.sorted(by: <)
    }
    
    func handleNextButton() {
        if items.count < numberOfGroups {
            let alert = UIAlertController(title: "Oops", message: "You must enter in values for each row in order to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        view.endEditing(true)
        if (!isInnerItemsMode) {
            saveToSingleton()
            dismiss(animated: true, completion: nil)
        } else {
            isInnerItemsMode = false
            title = "Outer Group"
            nextButton.title = "Done"
            tableView.reloadData()
        }
    }
    
    func saveToSingleton() {
        ChartData.Chart.innerGroupItems.append(contentsOf:innerItems.values)
        ChartData.Chart.outerGroupItems.append(contentsOf: outerItems.values)
    }
    
}


extension SetupGroupsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfGroups
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as? TextFieldTableViewCell else { fatalError() }
        let row = indexPath.row
        cell.row = row
        cell.delegate = self
        cell.textField.placeholder = "Item \(row)"
        cell.textField.text = items[row]
        cell.textField.returnKeyType = isLastRow(row: row) ? .continue : .next
        return cell
    }
}

extension SetupGroupsTableViewController: TextFieldCellDelegate {
    func returnTapped(cellRow: Int) {
        if isLastRow(row: cellRow) {
            handleNextButton()
        } else {
            editNextRow(lastRow: cellRow)
        }
    }
    
    func didEndEditing(value: String, row: Int) {
        // save value to dictionary
        if isInnerItemsMode {
            innerItems[row] = value
        } else {
            outerItems[row] = value
        }
    }
}






