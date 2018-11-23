//
//  CustomerServiceVC.swift
//  SimpliRealEstate
//
//  Created by mohammad on 7/10/18.
//  Copyright © 2018 mohammad. All rights reserved.
//

import UIKit

class CustomerServiceVC: UIViewController {

    @IBOutlet weak var accouuntButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        accouuntButton.addTarget(self, action: #selector(holdRelease), for: .touchUpInside)
        contactButton.addTarget(self, action: #selector(holdRelease), for: .touchUpInside)
        

        accouuntButton.addTarget(self, action: #selector(HoldDown), for: .touchDown)
        contactButton.addTarget(self, action: #selector(HoldDown), for: .touchDown)
        
    }
    
    @objc func HoldDown(button:UIButton){
        button.backgroundColor = UIColor.lightGray
    }
    @objc func holdRelease(button:UIButton){
        button.backgroundColor = UIColor(hexString: "3F4045")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
