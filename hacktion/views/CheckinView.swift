//
//  CheckinView.swift
//  Pilyumi
//
//  Created by reda.mimouni on 30/03/2019.
//  Copyright © 2019 Reda Mimouni. All rights reserved.
//

import UIKit

class CheckinView: UIView {
    @IBOutlet var hellYeah: UIButton!
    @IBOutlet var remindMe: UIButton!
    @IBOutlet var oops: UIButton!
    
    func initViews() {
        self.hellYeah?.layer.borderColor = UIColor.lightGray.cgColor
        self.hellYeah?.layer.borderWidth = 1
        self.hellYeah?.layer.cornerRadius = 5
        
        self.remindMe?.layer.borderColor = UIColor.lightGray.cgColor
        self.remindMe?.layer.borderWidth = 1
        self.remindMe?.layer.cornerRadius = 5
        
        self.oops?.layer.borderColor = UIColor.lightGray.cgColor
        self.oops?.layer.borderWidth = 1
        self.oops?.layer.cornerRadius = 5
    }
}
