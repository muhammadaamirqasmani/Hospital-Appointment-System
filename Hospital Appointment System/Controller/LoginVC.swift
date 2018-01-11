//
//  LoginVC.swift
//  Hospital Appointment System
//
//  Created by admin on 06/01/2018.
//  Copyright © 2018 MuhammadAamir. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet weak var PasswordTextField: UnderlinedTextField!
    @IBOutlet weak var EmailTextField: UnderlinedTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        guard let email = EmailTextField.text else {return}
        guard let pass = PasswordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if error ==  nil && user != nil{
                print("user Created")
                self.EmailTextField.text = ""
                self.PasswordTextField.text = ""
                self.dismiss(animated: true, completion: nil)
            }else {
                print("Error is \(String(describing: error?.localizedDescription))")
            
        }
        }
        
    }
    
    
}
