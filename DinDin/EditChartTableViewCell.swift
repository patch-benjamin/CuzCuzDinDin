//
//  EditChartTableViewCell.swift
//  DinDin
//
//  Created by Ben Patch on 1/16/17.
//  Copyright © 2017 PatchWork. All rights reserved.
//

import UIKit

class EditChartTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var rightTextField: UITextField!
}


extension EditChartTableViewCell: UITextFieldDelegate {
    override func endEditing(_ force: Bool) -> Bool {
        return true
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
