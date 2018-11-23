//
//  ForSaleCell.swift
//  SimpliRealEstate
//
//  Created by mohammad on 7/5/18.
//  Copyright © 2018 mohammad. All rights reserved.
//

import UIKit
import Firebase

class ForSaleCell: UITableViewCell {

    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var roomsLabel: UILabel!
    
    var snapshot:DocumentSnapshot!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
