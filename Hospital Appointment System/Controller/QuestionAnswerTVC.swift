//
//  QuestionAnswerTVC.swift
//  Hospital Appointment System
//
//  Created by admin on 09/01/2018.
//  Copyright © 2018 MuhammadAamir. All rights reserved.
//

import UIKit

class QuestionAnswerTVC: UITableViewCell {

    @IBOutlet weak var RadioView: UIView!
    @IBOutlet weak var AnswerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        RadioView.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
