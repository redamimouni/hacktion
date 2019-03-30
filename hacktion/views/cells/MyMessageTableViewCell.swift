//
//  MyMessageTableViewCell.swift
//  Pilyumi
//
//  Created by Mégane Menanteau on 30/03/2019.
//  Copyright © 2019 OCTO Technology. All rights reserved.
//

import UIKit

class MyMessageTableViewCell: UITableViewCell {

  @IBOutlet weak var bubbleView: UIView!
  @IBOutlet weak var messageLabel: UILabel!
  
  var message: String? {
    didSet {
      messageLabel?.text = message
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  
    setup()
  }
  
  private func setup() {
    bubbleView.layer.cornerRadius = bubbleView.frame.height / 2
  }
}
