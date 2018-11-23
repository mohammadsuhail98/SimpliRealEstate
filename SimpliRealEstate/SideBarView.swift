// //
////  SideBar.swift
////  SimpliRealEstate
////
////  Created by mohammad on 6/29/18.
////  Copyright © 2018 mohammad. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
// 
// protocol SidebarViewDelegate: class {
//    func sidebarDidSelectRow(row: Row)
// }
// 
// enum Row: String {
//    case settings
//    case customerService
//    case signOut
//    case none
//    
//    init(row: Int) {
//        switch row {
//        case 0: self = .settings
//        case 1: self = .customerService
//        case 2: self = .signOut
//        default: self = .none
//        }
//    }
// }
// 
// class SidebarView: UIView, UITableViewDelegate, UITableViewDataSource {
//    
//    var titleArr = [String]()
//    
//    weak var delegate: SidebarViewDelegate?
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor=UIColor.darkGray
//
//        self.clipsToBounds=true
//        
//        titleArr = ["Mohammad Suhail", "Settings", "Sign Out"]
//        
//      
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return titleArr.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.backgroundColor = .clear
//        cell.selectionStyle = .none
//        cell.textLabel?.text=titleArr[indexPath.row]
//        cell.textLabel?.textColor=UIColor.white
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.delegate?.sidebarDidSelectRow(row: Row(row: indexPath.row))
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0 {
//            return 100
//        } else {
//            return 60
//        }
//    }
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
// }
// 
// 
