//
//  MooMeter.swift
//  Pilyumi
//
//  Created by reda.mimouni on 30/03/2019.
//  Copyright © 2019 Reda Mimouni. All rights reserved.
//

import UIKit

class MoodMeter: UIView {
    @IBOutlet var fire: UIButton!
    @IBOutlet var rain: UIButton!
    @IBOutlet var soso: UIButton!
    @IBOutlet var angry: UIButton!
    
    func initViews() {
        self.fire?.layer.borderColor = UIColor.lightGray.cgColor
        self.fire?.layer.borderWidth = 1
        self.fire?.layer.cornerRadius = 5
        
        self.rain?.layer.borderColor = UIColor.lightGray.cgColor
        self.rain?.layer.borderWidth = 1
        self.rain?.layer.cornerRadius = 5
        
        self.soso?.layer.borderColor = UIColor.lightGray.cgColor
        self.soso?.layer.borderWidth = 1
        self.soso?.layer.cornerRadius = 5
        
        self.angry?.layer.borderColor = UIColor.lightGray.cgColor
        self.angry?.layer.borderWidth = 1
        self.angry?.layer.cornerRadius = 5
    }
}
