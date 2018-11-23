////
////  RentMoreInfo.swift
////  SimpliRealEstate
////
////  Created by mohammad on 7/5/18.
////  Copyright © 2018 mohammad. All rights reserved.
////
//
//import UIKit
//import Firebase
//class RentMoreInfo: UIViewController {
//    
//    var db:Firestore?
//
//
//    @IBOutlet weak var houseImage: UIImageView!
//    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var addressLabel: UILabel!
//    @IBOutlet weak var sizeLabel: UILabel!
//    @IBOutlet weak var roomsLabel: UILabel!
//    @IBOutlet weak var rateLabel: UILabel!
//    @IBOutlet weak var infoDesc: UITextView!
//    var snapshot:DocumentSnapshot!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        /// GET DOCUMNET BY ID
//        db = Firestore.firestore()
//        
//        let ref = db?.collection("forRent")
//        
//        if let data = snapshot.data() {
//            let imgString = data["imageString"] as? String ?? ""
//            if let url = URL(string: imgString) {
//                ImageService.getImage(withURL: url) { image in
//                    self.houseImage.image = image
//                }
//            }
//            priceLabel.text = data["pricePerMonth"] as? String ?? ""
//            addressLabel.text = data["address"] as? String ?? ""
//            roomsLabel.text = data["rooms"] as? String ?? ""
//            sizeLabel.text = data["size"] as? String ?? ""
//            rateLabel.text = data["rate"] as? String ?? ""
//            infoDesc.text = data["info"] as? String ?? ""
//            
//            
//            
//            
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//}
