//
//  SettingsVC.swift
//  SimpliRealEstate
//
//  Created by mohammad on 7/10/18.
//  Copyright © 2018 mohammad. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var notificationsButton: UIButton!
    @IBOutlet weak var manageAppStorageButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var legalButton: UIButton!
    @IBOutlet weak var settingsLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        countryButton.addTarget(self, action: #selector(holdRelease), for: .touchUpInside)
        notificationsButton.addTarget(self, action: #selector(holdRelease), for: .touchUpInside)
        manageAppStorageButton.addTarget(self, action: #selector(holdRelease), for: .touchUpInside)
        rateButton.addTarget(self, action: #selector(holdRelease), for: .touchUpInside)
        legalButton.addTarget(self, action: #selector(holdRelease), for: .touchUpInside)
        

        countryButton.addTarget(self, action: #selector(HoldDown), for: .touchDown)
        notificationsButton.addTarget(self, action: #selector(HoldDown), for: .touchDown)
        manageAppStorageButton.addTarget(self, action: #selector(HoldDown), for: .touchDown)
        rateButton.addTarget(self, action: #selector(HoldDown), for: .touchDown)
        legalButton.addTarget(self, action: #selector(HoldDown), for: .touchDown)

    }

    @objc func HoldDown(button:UIButton){
        button.backgroundColor = UIColor.lightGray
    }
    @objc func holdRelease(button:UIButton){
        button.backgroundColor = UIColor(hexString: "3F4045")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width )
        self.layer.addSublayer(border)
    }
}
