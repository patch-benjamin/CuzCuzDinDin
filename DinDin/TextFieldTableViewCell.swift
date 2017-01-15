//
//  TextFieldTableViewCell.swift
//  DinDin
//
//  Created by Ben Patch on 1/14/17.
//  Copyright © 2017 PatchWork. All rights reserved.
//

import UIKit

protocol TextFieldCellDelegate {
    func returnTapped(cellRow: Int)
    func didEndEditing(value: String, row: Int)
}

class TextFieldTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var delegate: TextFieldCellDelegate?
    var row = 0;
    var value: String {
        return textField.text ?? ""
    }
    var validValue: Bool {
        return value != ""
    }
    
    @IBOutlet weak var textField: UITextField!
    
}


extension TextFieldTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.returnTapped(cellRow: row)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing(value: textField.text ?? "", row: row)
    }
}
