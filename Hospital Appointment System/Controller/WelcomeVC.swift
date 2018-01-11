//
//  WelcomeVC.swift
//  Hospital Appointment System
//
//  Created by admin on 06/01/2018.
//  Copyright © 2018 MuhammadAamir. All rights reserved.
//

import UIKit
import Firebase
class WelcomeVC: UIViewController {

    var quoteListener: ListenerRegistration!
    var appDelegte = UIApplication.shared.delegate as! AppDelegate
    var segueVariable = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Auth.auth().currentUser != nil{
            let uid = Auth.auth().currentUser?.uid
//            let userType = Auth.auth().currentUser?.
            quoteListener = Firestore.firestore().collection("HospitalAppointmentUser").whereField("uid", isEqualTo: uid).addSnapshotListener({  (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        self.appDelegte.UserProfleImage = document.data()["ImageURL"] as? String
                        self.appDelegte.UserName = document.data()["UserName"] as? String
                        self.appDelegte.UserType = document.data()["UserType"] as? String
                        if self.appDelegte.UserType == "Patient"{
                            self.performSegue(withIdentifier: "PatientLogin", sender: self)
                        } else if self.appDelegte.UserType == "Doctor" {
                            self.performSegue(withIdentifier: "DoctorLogin", sender: self)
                        }else if self.appDelegte.UserType == "Nurse" {
                            self.performSegue(withIdentifier: "NurseLogin", sender: self)
                        }
                        
                    }
                }
            })
            
        }
        
    }


    @IBAction func signUp(_ sender: Any) {
        
        
        // create the alert
        let alert = UIAlertController(title: "SignUp", message: "I am Sign Up as a:", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Patient", style: UIAlertActionStyle.default, handler: { action in
            self.segueVariable = "Patient"
            self.seguePerforming(PerformWhere: self.segueVariable)
        }))
        alert.addAction(UIAlertAction(title: "Doctor", style: UIAlertActionStyle.default, handler: { action in
            self.segueVariable = "Doctor"
            self.seguePerforming(PerformWhere: self.segueVariable)
        }))
        alert.addAction(UIAlertAction(title: "Admin / Nurse", style: UIAlertActionStyle.default, handler: { action in
            self.segueVariable = "Nurse"
            self.seguePerforming(PerformWhere: self.segueVariable)
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
        
    }
  
    func seguePerforming(PerformWhere:String) {
        
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desVC = mainStoryboard.instantiateViewController(withIdentifier: "Doctor") as! SignupVC
        desVC.DataField = segueVariable
            desVC.modalTransitionStyle = .flipHorizontal
            self.present(desVC, animated: true, completion: nil)
     
    }
}

