//
//  SaleMoreInfo.swift
//  SimpliRealEstate
//
//  Created by mohammad on 7/5/18.
//  Copyright © 2018 mohammad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreUI


class SaleMoreInfo: UIViewController {
    var db:Firestore?
    var storage:Storage!
    var dataSource:FUIFirestoreTableViewDataSource!
    
    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var roomsLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var infoDesc: UITextView!
    var snapshot:DocumentSnapshot!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        var fav = UserDefaults.standard
            let ref = db?.collection("forSale")

        if let data = snapshot.data() {
            let imgString = data["imageString"] as? String ?? ""
            if let url = URL(string: imgString) {
                ImageService.getImage(withURL: url) { image in
                    self.houseImage.image = image
                }
            }
            price.text = data["price"] as? String ?? ""
            addressLabel.text = data["address"] as? String ?? ""
            roomsLabel.text = data["rooms"] as? String ?? ""
            sizeLabel.text = data["size"] as? String ?? ""
            rateLabel.text = data["rate"] as? String ?? ""
            infoDesc.text = data["info"] as? String ?? ""
            
        }
    }
//
//    @IBAction func AddToFav(_ sender: Any) {
//
//        guard let userProfile = UserService.currentUserProfile else { return }
//        let id = snapshot.documentID
//        userProfile.fav.insert(id, at: 0)
//
//        var coll:[String] = ["forRent","forSale"]
//        db = Firestore.firestore()
//        storage = Storage.storage()
//        let ref2 = db?.collection("favorite")
//
//
//        for y in coll {
//            for x in userProfile.fav {
//                let ref = db?.collection(y).document(x)
//                ref?.getDocument(completion: { (doc, error) in
//                    if let doc = doc {
//                        let data = doc.data()
//                        if let data = data {
//                            let send:[String : Any] = [
//                                "address":data["address"] as? String ?? "",
//                                "imageString":data["imageString"] as? String ?? "",
//                                "info":data["info"] as? String ?? "",
//                                "price":data["price"] as? String ?? "",
//                                "rate":data["rate"] as? String ?? "",
//                                "rooms":data["rooms"] as? String ?? "",
//                                "size":data["size"] as? String ?? ""
//                            ]
//
//                            ref2?.addDocument(data: send, completion: { (error) in
//                                if let error = error {
//                                    print("\(error.localizedDescription)")
//                                }
//                                else {
//                                    print("document added")
//                                }
//                            })
//
//
//                        }
//                    }
//                })
//
//            }
//        }
//
//    }
//

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
