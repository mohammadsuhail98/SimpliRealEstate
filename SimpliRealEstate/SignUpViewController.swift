//
//  SignUpViewController.swift
//  SimpliRealEstate
//
//  Created by mohammad on 6/30/18.
//  Copyright © 2018 mohammad. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var tabToChangeButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var imagePicker:UIImagePickerController!
    var t = false

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollViewOutlet.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameText.resignFirstResponder()
        emailText.resignFirstResponder()
        passwordText.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollViewOutlet.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func alert(title:String, messsage:String, buttonTitle:String? = "Ok", completion:(()-> Void)? = nil){
        
        let Alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: buttonTitle, style: .default) { (action) in
            if let completion = completion {
                completion()
            }
        }
        Alert.addAction(okayAction)
        self.present(Alert, animated: true, completion: nil)
    }
    
    
    @objc func UpdateData() {
        if let user = Auth.auth().currentUser {
            
            guard let userProfile = UserService.currentUserProfile else { return }
            Auth.auth().updateCurrentUser(user) { (error) in
                if error == nil {
                    let password = self.passwordText.text as! String ?? ""
                    let username = self.usernameText.text as! String ?? ""
                    let email = self.emailText.text as! String ?? ""

                    let image = self.profileImageView.image
                    
                    
                    self.uploadProfileImage(image!) { url in
                        
                        if url != nil {
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = username
                            changeRequest?.photoURL = url
                            user.updateEmail(to: email, completion: nil)
                            user.updatePassword(to: password, completion: nil)

                            changeRequest?.commitChanges { error in
                                if error == nil {
                                    print("User display name changed!")
                                    
                                    self.saveProfile(username: username, profileImageURL: url!) { success in
                                        if success {
                                            let viewS = self.storyboard?.instantiateViewController(withIdentifier: "main")
                                            self.navigationController?.pushViewController(viewS!, animated: true)
                                        }
                                        else {
                                            self.alert(title: "error", messsage: error!.localizedDescription)
                                            
                                        }
                                    }
                                    
                                } else {
                                    print("Error: \(error!.localizedDescription)")
                                    self.alert(title: "error", messsage: error!.localizedDescription)
                                }
                            }
                        } else {
                            self.alert(title: "error", messsage: error!.localizedDescription)
                        }
                        
                    }
                }
            }
            
        }
    }
    @objc func SignUpFunc() {
        guard let username = usernameText.text else { return }
        guard let email = emailText.text else { return }
        guard let password = passwordText.text else { return }
        guard let img = profileImageView.image else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("user created")
                self.navigationController?.popViewController(animated: true)
                
                
                // 1. Upload the profile image to Firebase Storage
                
                self.uploadProfileImage(img) { url in
                    
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = username
                        changeRequest?.photoURL = url
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                print("User display name changed!")
                                
                                self.saveProfile(username: username, profileImageURL: url!) { success in
                                    if success {
                                        let viewS = self.storyboard?.instantiateViewController(withIdentifier: "main")
                                        self.navigationController?.pushViewController(viewS!, animated: true)
                                    }
                                    else {
                                        self.alert(title: "error", messsage: error!.localizedDescription)
                                        
                                    }
                                }
                                
                            } else {
                                print("Error: \(error!.localizedDescription)")
                                self.alert(title: "error", messsage: error!.localizedDescription)
                            }
                        }
                    } else {
                        self.alert(title: "error", messsage: error!.localizedDescription)
                    }
                    
                }
                
            } else {
                self.alert(title: "error", messsage: error!.localizedDescription)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if t == true {
            signupButton.setTitle("Update", for: .normal)
            if let user = Auth.auth().currentUser {
                
                guard let userProfile = UserService.currentUserProfile else { return }
                ImageService.getImage(withURL: userProfile.photoURL) { image in
                    self.profileImageView.image = image
                }
                usernameText.text = userProfile.userName
                emailText.text = user.email
                passwordText.text = nil
            }
            signupButton.addTarget(self, action: #selector(UpdateData), for: .touchUpInside)
        }
        else {
            signupButton.addTarget(self, action: #selector(SignUpFunc), for: .touchUpInside)

        }
        
        signupButton.layer.cornerRadius = 13
        signupButton.layer.masksToBounds = true
        signupButton.layer.borderWidth = 0
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([donebutton], animated: false)
        
        usernameText.inputAccessoryView = toolbar
        emailText.inputAccessoryView = toolbar
        passwordText.inputAccessoryView = toolbar
        
        func doneClicked(){
            view.endEditing(true)
        }
    
        usernameText.setBottomBorder()
        emailText.setBottomBorder()
        passwordText.setBottomBorder()
        usernameText.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        emailText.attributedPlaceholder = NSAttributedString(string: "E-mail",
                                                                attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        passwordText.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(imageTap)
        
    }

    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    @objc func openImagePicker(_ sender:Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func OpenImagePicker(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func SignUp(_ sender: Any) {
        
  

    }
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
        
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                if let url = metaData?.downloadURL() {
                    completion(url)
                } else {
                    completion(nil)
                }
                // success!
            } else {
                // failed
                completion(nil)
            }
        }
    }
    
    func saveProfile(username:String, profileImageURL:URL, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {

            self.profileImageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

