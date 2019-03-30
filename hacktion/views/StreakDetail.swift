//
//  StreakDetail.swift
//  Pilyumi
//
//  Created by reda.mimouni on 30/03/2019.
//  Copyright © 2019 Reda Mimouni. All rights reserved.
//

import UIKit

class StreakDetail: UIView {
    @IBOutlet var sharedButton: UIButton!
    @IBOutlet var sharedText: UILabel!

    @IBAction func sharedClicked() {
        if sharedButton.isEnabled {
            sharedButton.isEnabled = false
            sharedText.textColor = UIColor(red: 86/255, green: 205/255, blue: 113/255, alpha: 1)
            sharedText.text = "Sharing on"
        }
        
    }
}
