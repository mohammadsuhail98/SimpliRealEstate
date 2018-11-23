//
//  ForRentModel.swift
//  SimpliRealEstate
//
//  Created by mohammad on 7/7/18.
//  Copyright © 2018 mohammad. All rights reserved.
//

import Foundation

class ForRent {
    var address, pricePerMonth, rooms, info:String
    var rate:String
    var imageURL:URL
    
    init(address:String, pricePerMonth:String, rooms:String,info:String,rate:String, imageURL:URL) {
        self.address = address
        self.pricePerMonth = pricePerMonth
        self.rooms = rooms
        self.info = info
        self.rate = rate
        self.imageURL = imageURL
    }
}
