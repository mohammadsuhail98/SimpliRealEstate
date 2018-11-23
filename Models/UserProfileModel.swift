//
//  UserProfileModel.swift
//  SimpliRealEstate
//
//  Created by mohammad on 7/2/18.
//  Copyright © 2018 mohammad. All rights reserved.
//

import Foundation


class UserProfile {
    var uid:String
    var userName:String
    var photoURL:URL
    var fav:[String]
    
    init(uid:String, userName:String, photoURL:URL, fav:[String]) {
        self.uid = uid
        self.userName = userName
        self.photoURL = photoURL
        self.fav = fav
    }
}

