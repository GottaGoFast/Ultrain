//
//  TrainerProfileCell.swift
//  Ultrain
//
//  Created by Yifu Ma on 4/15/16.
//  Copyright © 2016 Yifu Ma. All rights reserved.
//

import UIKit

class TrainerProfileCell: UITableViewCell {

    @IBOutlet weak var pastExperience: UITextView!
    @IBOutlet weak var Introduction: UITextView!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
