//
//  ViewController.swift
//  SimpliRealEstate
//
//  Created by mohammad on 6/28/18.
//  Copyright © 2018 mohammad. All rights reserved.
//

import UIKit
import Firebase
import SwiftHEXColors
import FirebaseFirestoreUI
import BubbleTransition


class ViewController: UIViewController {

    @IBOutlet weak var guideButton: UIButton!
    
    @IBOutlet weak var menueButton: UIBarButtonItem!
    @IBOutlet weak var rent: UIButton!
    @IBOutlet weak var sale: UIButton!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var viewMenue: UIView!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var customerServiceButton: UIButton!
    
    var blackScreen: UIView!
    
    var menueShowing = false
    var db:Firestore!
    var storage:Storage!
    var dataSource:FUIFirestoreTableViewDataSource!

    var leftBarButtonItem : UIBarButtonItem!

    
//    @IBAction func Favorite(_ sender: Any) {
//
//        var favorite = storyboard?.instantiateViewController(withIdentifier: "fav") as! ForRentTableViewController
//        navigationController?.pushViewController(favorite, animated: true)

//        db = Firestore.firestore()
//        storage = Storage.storage()
//        
//        guard let userProfile = UserService.currentUserProfile else { return }
//        
//        for x in userProfile.fav {
//            let ref = db.collection("forRent").document(x)
//            ref.getDocument(completion: { (doc, error) in
//                if let doc = doc {
//
//                    let data = doc.data()
//                    if let data = data {
//                        print(x)
//
//                        let title = data["address"] as? String ?? ""
//                        print(title)
//                    }
//                }
//            })
//            
//        }
//
//    }
    

    

  
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
    
    @IBAction func RentFunction(_ sender: Any) {

        var table = storyboard?.instantiateViewController(withIdentifier: "forSale") as! ForSaleTableViewController
        navigationController?.pushViewController(table, animated: true)
        table.d = false
        
    }
    @IBAction func SaleFunction(_ sender: Any) {

        var table = storyboard?.instantiateViewController(withIdentifier: "forSale") as! ForSaleTableViewController
        navigationController?.pushViewController(table, animated: true)
        table.d = true

    }
    
    @IBAction func ShowProfile(_ sender: Any) {
        
        if let user = Auth.auth().currentUser {
            var profile = storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileVC
            navigationController?.pushViewController(profile, animated: true)
        }
    }
    
    
    @IBAction func MoveToLoginPage(_ sender: Any) {
        
        if let user = Auth.auth().currentUser {
             alert(title: "Error", messsage: "You are already signed in")
        }
        else {
            let login = storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
            navigationController?.pushViewController(login, animated: true)
        }
    }
    @IBAction func closeMenue(_ sender: UITapGestureRecognizer) {
        
        if menueShowing {
            leadingConstraint.constant = -240

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "menu- 2"), style: .plain, target: self, action: #selector(ActionMenue))
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white

        }
    }
    
    
    @objc func ActionMenue(){
        if menueShowing {
            leadingConstraint.constant = -240
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu- 2"), style: .plain, target: self, action: #selector(ActionMenue))
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        else {
            leadingConstraint.constant = 0
            self.navigationItem.leftBarButtonItem = nil

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        menueShowing = !menueShowing
        guard let userProfile = UserService.currentUserProfile else { return }
        ImageService.getImage(withURL: userProfile.photoURL) { image in
            self.userImage.image = image
            self.userName.text = userProfile.userName
    }
    }
    
    @IBAction func SignOut(_ sender: Any) {
        if let user = Auth.auth().currentUser {
            try! Auth.auth().signOut()
            userName.text = nil
            userImage.image = #imageLiteral(resourceName: "user")
            alert(title: "sign out completed", messsage: "")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userName.text = nil

 
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu- 2"), style: .plain, target: self, action: #selector(ActionMenue))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        

        viewMenue.layer.shadowOpacity = 1
        viewMenue.layer.shadowRadius = 6
        
        rent.layer.cornerRadius = 10
        rent.layer.masksToBounds = true
        rent.layer.borderWidth = 1
        rent.layer.borderColor = UIColor.white.cgColor
        sale.layer.cornerRadius = 10
        sale.layer.masksToBounds = true
        sale.layer.borderWidth = 1
        sale.layer.borderColor = UIColor.white.cgColor
        
        userImage.layer.cornerRadius = 0.5 * userImage.bounds.size.width
        userImage.layer.masksToBounds = true
        
        settingButton.addTarget(self, action: #selector(holdRelease), for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(HoldDown), for: .touchDown)
        customerServiceButton.addTarget(self, action: #selector(holdRelease), for: .touchUpInside)
        customerServiceButton.addTarget(self, action: #selector(HoldDown), for: .touchDown)
        signOutButton.addTarget(self, action: #selector(holdRelease), for: .touchUpInside)
        signOutButton.addTarget(self, action: #selector(HoldDown), for: .touchDown)
        
        rent.addTarget(self, action: #selector(holdReleaseSR), for: .touchUpInside)
        rent.addTarget(self, action: #selector(HoldDownSR), for: .touchDown)
        sale.addTarget(self, action: #selector(holdReleaseSR), for: .touchUpInside)
        sale.addTarget(self, action: #selector(HoldDownSR), for: .touchDown)


    }
    @objc func HoldDown(button:UIButton){
        button.backgroundColor = UIColor(hexString: "577FBE")
    }
    @objc func holdRelease(button:UIButton){
        button.backgroundColor = UIColor(hexString: "3F4045")
    }
    @objc func HoldDownSR(button:UIButton){
        button.backgroundColor = UIColor(hexString: "577FBE")
    }
    @objc func holdReleaseSR(button:UIButton){
        button.backgroundColor = UIColor.clear
    }
}


