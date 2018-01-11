//
//  AppointmentTVC.swift
//  Hospital Appointment System
//
//  Created by admin on 09/01/2018.
//  Copyright © 2018 MuhammadAamir. All rights reserved.
//

import UIKit

class AppointmentTVC: UITableViewCell {

    @IBOutlet weak var DoctImage: UIImageView!
    @IBOutlet weak var Timing: UILabel!
    @IBOutlet weak var DoctorName: UILabel!
    @IBOutlet weak var appointmentDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.DoctImage.layer.cornerRadius = 50
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
