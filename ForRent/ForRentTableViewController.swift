////
////  ForRentTableViewController.swift
////  SimpliRealEstate
////
////  Created by mohammad on 7/5/18.
////  Copyright © 2018 mohammad. All rights reserved.
////
//
//import UIKit
//import Firebase
//import FirebaseFirestoreUI
//
//class ForRentTableViewController: UITableViewController {
//
//    
//    var db:Firestore!
//    var storage:Storage!
//    var dataSource:FUIFirestoreTableViewDataSource!
//    
//    func alert(title:String, messsage:String, buttonTitle:String? = "Ok", completion:(()-> Void)? = nil){
//        
//        let Alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
//        let okayAction = UIAlertAction(title: buttonTitle, style: .default) { (action) in
//            if let completion = completion {
//                completion()
//            }
//        }
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        
//  
//        
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let db = Firestore.firestore()
//        let ref = db.collection("favorite")
//        let query = ref.limit(to: 30)
//
//        self.dataSource = tableView.bind(toFirestoreQuery: query, populateCell: { (tableView, indexPath, snapshot) -> UITableViewCell in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "favCell") as! FavCell
//            if let data = snapshot.data() {
//
//                cell.priceLabel.text = data["price"] as? String ?? ""
//                cell.addressLabel.text = data["address"] as? String ?? ""
//                cell.roomsLabel.text = data["rooms"] as? String ?? ""
//
//
//                let imgString = data["imageString"] as? String ?? ""
//                if let url = URL(string: imgString) {
//                    ImageService.getImage(withURL: url) { image in
//                        cell.imageString.image = image
//                    }
//                }
//
//
//            }
//            return cell
//
//        })
//
//      
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
////        let cell = tableView.cellForRow(at: indexPath) as! ForRentCell
////
////        let info = storyboard?.instantiateViewController(withIdentifier: "rentInfo") as! RentMoreInfo
////        navigationController?.pushViewController(info, animated: true)
////
////        info.snapshot = cell.snapshot
//        
//    }
//
////    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////         let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! FavCell
////         let f = favorite[indexPath.row]
////         cell.addressLabel.text = f.address
////        let url = f.imageURL
////            ImageService.getImage(withURL: url) { image in
////            cell.imageString.image = image
////        }
////        cell.roomsLabel.text = f.rooms
////        cell.priceLabel.text = f.price
////
////        return cell
////    }
////
//    
////    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return favorite.count
////    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//}
