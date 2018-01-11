//
//  PatientWelcomeVC.swift
//  Hospital Appointment System
//
//  Created by admin on 08/01/2018.
//  Copyright © 2018 MuhammadAamir. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class PatientWelcomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    

    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var UserImage: UIImageView!
    var appDelegte = UIApplication.shared.delegate as! AppDelegate
    
    var Image = UIImage()
    var appointmentDetailArray = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UserImage.layer.cornerRadius = 50
        self.UserImage.layer.masksToBounds = true
        self.Name.text = "Welcome \(appDelegte.UserName!)"
        let url = URL(string: appDelegte.UserProfleImage!)
        self.UserImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
    }


    @IBAction func StartQuiz(_ sender: Any) {
        
    }
    
    @IBAction func Logout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentDetailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AppointmentTVC
        return Cell
    }
}
