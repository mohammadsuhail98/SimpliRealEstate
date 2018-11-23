//
//  ProfileVC.swift
//  SimpliRealEstate
//
//  Created by mohammad on 7/12/18.
//  Copyright © 2018 mohammad. All rights reserved.
//

import UIKit
import Firebase
class ProfileVC: UIViewController {

    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var editAccountButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
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
        
        userPhoto.layer.cornerRadius = 0.5 * userPhoto.bounds.size.width
        userPhoto.layer.masksToBounds = true

        if let user = Auth.auth().currentUser {
            
            guard let userProfile = UserService.currentUserProfile else { return }
            ImageService.getImage(withURL: userProfile.photoURL) { image in
                self.userPhoto.image = image
                self.userName.text = userProfile.userName
            }
        }
        else {
            print("does not exist")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func EditAccount(_ sender: Any) {
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "signUp") as! SignUpViewController
        self.navigationController?.pushViewController(signUp, animated: true)
        signUp.t = true
       
    }
    @IBAction func DeleteAccount(_ sender: Any) {
        Auth.auth().currentUser?.delete(completion: { (error) in
            if error == nil {
                let viewS = self.storyboard?.instantiateViewController(withIdentifier: "main")
                self.navigationController?.pushViewController(viewS!, animated: true)
            }
            else {
                print("error")
            }
        })
    }
    
}
