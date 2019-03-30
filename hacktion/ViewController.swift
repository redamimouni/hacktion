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
  
  var timer: Timer!
  var nextPillDate: Date!
  
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
    return 5
  }
  
  func carousel(_ carousel: iCarousel!, viewForItemAt index: Int, reusing view: UIView!) -> UIView! {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: carousel.frame.width - 160, height: carousel.frame.height))
    view.backgroundColor = index % 2 == 0 ? .red : .blue
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: carousel.frame.width, height: 50))
    label.text = "Titre"
    view.addSubview(label)
    return view
  }
}

extension ViewController: iCarouselDelegate {
  func carousel(_ carousel: iCarousel!, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
    if option == .spacing {
      return value * 1.05
    }
    return value
  }
}
