//
//  ViewController.swift
//  hacktion
//
//  Created by reda.mimouni on 29/03/2019.
//  Copyright © 2019 Reda Mimouni. All rights reserved.
//

import UIKit
import iCarousel

class ViewController: UIViewController {

  @IBOutlet weak var countdownLabel: UILabel!
  @IBOutlet weak var carouselView: iCarousel!
  
  private var timer: Timer!
  private var nextPillDate: Date!
  
  private let colors: [UIColor] = [
    UIColor(red: 1/255, green: 140/255, blue: 203/255, alpha: 1),
    UIColor(red: 108/255, green: 184/255, blue: 255/255, alpha: 1),
    UIColor(red: 0/255, green: 86/255, blue: 180/255, alpha: 1),
    UIColor(red: 105/255, green: 55/255, blue: 146/255, alpha: 1)
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nextPillDate = Date(timeIntervalSinceNow: 5000)
    
    carouselView.reloadData()
    carouselView.type = .linear
    carouselView.currentItemIndex = carouselView.numberOfItems / 2
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
  }
  
  @objc private func updateCountdown() {
    let currentDate = Date()
    
    guard nextPillDate > currentDate else {
      timer.invalidate()
      return
    }
    let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: currentDate, to: nextPillDate)
    countdownLabel.text = String(format: "%02d:%02d:%02d", dateComponents.hour!, dateComponents.minute!, dateComponents.second!)
  }
}

extension ViewController: iCarouselDataSource {
  func numberOfItems(in carousel: iCarousel!) -> Int {
    return 4
  }
  
  func carousel(_ carousel: iCarousel!, viewForItemAt index: Int, reusing view: UIView!) -> UIView! {
    let marginX: CGFloat = 65
    
    let itemView = UIView(frame: CGRect(x: 0, y: 0, width: carousel.frame.width - marginX * 2, height: carousel.frame.height))
    itemView.backgroundColor = .white
    itemView.layer.cornerRadius = 12
    
    let label = UILabel(frame: CGRect(x: 0, y: 20, width: itemView.frame.width, height: 50))
    label.text = "Titre"
    label.textAlignment = .center
    
    itemView.addSubview(label)
    return itemView
  }
}

extension ViewController: iCarouselDelegate {
  func carousel(_ carousel: iCarousel!, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
    if option == .spacing {
      return value * 1.05
    }
    return value
  }
  
  func carouselCurrentItemIndexDidChange(_ carousel: iCarousel!) {
    view.backgroundColor = colors[carousel.currentItemIndex]
  }
}
