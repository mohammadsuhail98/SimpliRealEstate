//
//  ForSaleModel.swift
//  SimpliRealEstate
//
//  Created by mohammad on 7/5/18.
//  Copyright © 2018 mohammad. All rights reserved.
//

import Foundation


class ForSale {
    var address, price, rooms, info:String
    var rate:String
    var imageURL:URL
    
    init(address:String, price:String, rooms:String,info:String,rate:String, imageURL:URL) {
       self.address = address
        self.price = price
        self.rooms = rooms
        self.info = info
        self.rate = rate
        self.imageURL = imageURL
    }
}
