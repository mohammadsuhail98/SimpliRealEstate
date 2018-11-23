//
//  ForSaleTableViewController.swift
//  SimpliRealEstate
//
//  Created by mohammad on 7/5/18.
//  Copyright © 2018 mohammad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreUI


class ForSaleTableViewController: UITableViewController {
    
    var db:Firestore!
    var storage:Storage!
    var dataSource:FUIFirestoreTableViewDataSource!
    var d:Bool!
    
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
        
        db = Firestore.firestore()
        storage = Storage.storage()

        if d == true {
            
            let ref = db.collection("forSale")
            let query = ref.limit(to: 30)
            
            self.dataSource = tableView.bind(toFirestoreQuery: query, populateCell: { (tableView, indexPath, snapshot) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "forSaleCell") as! ForSaleCell
                if let data = snapshot.data() {
                    
                    cell.priceLabel.text = data["price"] as? String ?? ""
                    cell.addressLabel.text = data["address"] as? String ?? ""
                    cell.roomsLabel.text = data["rooms"] as? String ?? ""
                    cell.snapshot = snapshot
                    
                    
                    let imgString = data["imageString"] as? String ?? ""
                    if let url = URL(string: imgString) {
                        ImageService.getImage(withURL: url) { image in
                            cell.houseImage.image = image
                        }
                    }
                    
                    
                }
                
                return cell
                
            })
        }
            
        else {
            let ref = db.collection("forRent")
            let query = ref.limit(to: 30)
            
            self.dataSource = tableView.bind(toFirestoreQuery: query, populateCell: { (tableView, indexPath, snapshot) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "forSaleCell") as! ForSaleCell
                if let data = snapshot.data() {
                    
                    cell.priceLabel.text = data["price"] as? String ?? ""
                    cell.addressLabel.text = data["address"] as? String ?? ""
                    cell.roomsLabel.text = data["rooms"] as? String ?? ""
                    cell.snapshot = snapshot
                    
                    
                    let imgString = data["imageString"] as? String ?? ""
                    if let url = URL(string: imgString) {
                        ImageService.getImage(withURL: url) { image in
                            cell.houseImage.image = image
                        }
                    }
                }
                
                return cell
                
            })

        
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ForSaleCell

            if let user = Auth.auth().currentUser {

                let info = storyboard?.instantiateViewController(withIdentifier: "info") as! SaleMoreInfo
                navigationController?.pushViewController(info, animated: true)
        
                info.snapshot = cell.snapshot
            }
            else {
                alert(title: "Sorry", messsage: "you need to login first")
            }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
}
