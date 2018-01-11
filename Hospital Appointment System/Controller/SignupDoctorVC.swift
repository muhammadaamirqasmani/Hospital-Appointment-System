//
//  SignupDoctorVC.swift
//  Hospital Appointment System
//
//  Created by admin on 06/01/2018.
//  Copyright © 2018 MuhammadAamir. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: UIViewController {

    
    @IBOutlet weak var Address: UnderlinedTextField!
    @IBOutlet weak var DateOfBirth: UnderlinedTextField!
    @IBOutlet weak var ContactNo: UnderlinedTextField!
    @IBOutlet weak var Email: UnderlinedTextField!
    @IBOutlet weak var RePassword: UnderlinedTextField!
    @IBOutlet weak var Password: UnderlinedTextField!
    @IBOutlet weak var UserLastName: UnderlinedTextField!
    @IBOutlet weak var UserName: UnderlinedTextField!
    @IBOutlet weak var DismissBtn: UIButton!
    
    var imagePicker = UIImagePickerController()
    var data = NSData()
    var docRef : DocumentReference? = nil
    let db = Firestore.firestore()
    var DataField = "Doctor"
    override func viewDidLoad() {
        super.viewDidLoad()
        UserName.placeholder = "\(DataField) Name"
        UserLastName.placeholder = "\(DataField) Last Name"
    }

    func uploadImageTOFirebaseStorage(data: NSData){
        let storage = Storage.storage().reference(withPath: "\(DataField)/userImage/\(String(describing: Email.text)).jpeg")
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        let uploadTask = storage.putData(data as Data, metadata: uploadMetaData) { (metadata, error) in
            if (error != nil){
                print("I received an error! \(String(describing: error?.localizedDescription))")
            }else {
                let downloadURL = metadata?.downloadURL()?.absoluteString
                print("Upload Complete! Here's some metadata! \(String(describing: metadata))")
                print("This is Firebase image ___________URL____________\(String(describing: downloadURL))")
                
                let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    // Your code with delay
                    guard let UserName = self.UserName.text else {return}
                    guard let UserEmail = self.Email.text else {return}
                    guard let UserPassword = self.Password.text else {return}
                    guard let Address = self.Address.text else {return}
                    guard let DateOfBirth = self.DateOfBirth.text else {return}
                    guard let ContactNo = self.ContactNo.text else {return}
                    guard let UserLastName = self.UserLastName.text else {return}
                    
                    let userID = Auth.auth().currentUser!.uid
                    self.getDataFromController(UserName: UserName, UserEmail: UserEmail, UserPassword: UserPassword, uid:userID, ImageURL: downloadURL!, Address: Address, DateOfBirth: DateOfBirth, ContactNo: ContactNo, UserLastName: UserLastName, UserType: self.DataField)
                    self.Address.text = ""
                    self.DateOfBirth.text = ""
                    self.ContactNo.text = ""
                    self.UserLastName.text = ""
                    self.UserName.text = ""
                    self.Email.text! = ""
                    self.Password.text! = ""
                    self.RePassword.text = ""
                }
            }
        }
    }
    func getDataFromController (UserName: String, UserEmail: String, UserPassword: String, uid: String, ImageURL: String , Address: String, DateOfBirth: String, ContactNo: String, UserLastName: String, UserType: String){
        let docData: [String: Any] = ["UserName": UserName, "UserEmail": UserEmail, "UserPassword": UserPassword, "uid": uid, "ImageURL": ImageURL,"UserType": UserType,"UserLastName": UserLastName ,"ContactNo": ContactNo ,"DateOfBirth": DateOfBirth,"Address": Address]
        docRef = db.collection("HospitalAppointmentUser").addDocument(data: docData){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.docRef!.documentID)")
            }
        }
    }

    @IBAction func SignUpAction(_ sender: Any) {
        if  (!((Email.text?.isEmpty)!) && !((Password.text?.isEmpty)!) && (Password.text == RePassword.text) && !((Address.text?.isEmpty)!) && !((DateOfBirth.text?.isEmpty)!) && !((ContactNo.text?.isEmpty)!) && !((UserLastName.text?.isEmpty)!) && !((UserName.text?.isEmpty)!) ){
            let email = Email.text!
            let password = Password.text!
            
            
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { (success, error) in
                if error == nil{
                    print("SUCCESS")
                    self.uploadImageTOFirebaseStorage(data: self.data)
                    self.dismiss(animated: true, completion: nil)
                    
                }
                else {
                    // ACTION ON GETTING ERROR
                    
                }
            })
        }
            
        else{
            print("textField is empty")
            
        }
    }
    
    @IBAction func UploadImage(_ sender: Any) {
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate=self
        
        let actionController = UIAlertController(title: "Profile Image", message: "Please select profile image for Distill", preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        actionController.addAction(galleryAction)
        actionController.addAction(cancel)
        actionController.addAction(cameraAction)
        self.present(actionController, animated: true, completion: nil)
        
    }
    @IBAction func DismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension SignupVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //        self.ProfileImage.image = image
        self.data = UIImageJPEGRepresentation(image, 0.8)! as NSData
        self.dismiss(animated: true, completion: nil)
    }
}
