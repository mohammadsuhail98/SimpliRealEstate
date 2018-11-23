//
//  LoginViewController.swift
//  SimpliRealEstate
//
//  Created by mohammad on 6/30/18.
//  Copyright © 2018 mohammad. All rights reserved.
//

import UIKit
import SwiftHEXColors
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.layer.cornerRadius = 13
        doneButton.layer.masksToBounds = true
        doneButton.layer.borderWidth = 0
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([donebutton], animated: false)
        
        emailText.inputAccessoryView = toolbar
        passwordText.inputAccessoryView = toolbar
        
        func doneClicked(){
            view.endEditing(true)
        }

        emailText.setBottomBorder()
        passwordText.setBottomBorder()
        emailText.attributedPlaceholder = NSAttributedString(string: "E-mail",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        passwordText.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
    

        
        
    }
    
    @objc func doneClicked(){
        view.endEditing(true)
    }
    @IBAction func login(_ sender: Any) {
        
        guard let email = emailText.text else { return }
        guard let password = passwordText.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                let viewS = self.storyboard?.instantiateViewController(withIdentifier: "main")
                self.navigationController?.pushViewController(viewS!, animated: true)
                
             } else {
                print("Error logging in: \(error!.localizedDescription)")
                self.alert(title: "error", messsage: error!.localizedDescription)
            }
        }
        
    }
    
}
extension UITextField {
    
    func setBottomBorder(){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
