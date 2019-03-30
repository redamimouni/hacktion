//
//  ViewController.swift
//  hacktion
//
//  Created by reda.mimouni on 29/03/2019.
//  Copyright © 2019 Reda Mimouni. All rights reserved.
//

import UIKit
import FSCalendar
import iCarousel

class ViewController: UIViewController {

  @IBOutlet weak var countdownLabel: UILabel!
  @IBOutlet weak var calendarView: FSCalendar!
  @IBOutlet weak var carouselView: iCarousel!
  
  private static let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    return dateFormatter
  }()
  
  private var timer: Timer!
  private var nextPillDate: Date!
  private let validatedPillDates: [Date] = [
    dateFormatter.date(from: "2019-03-01")!,
    dateFormatter.date(from: "2019-03-02")!,
    dateFormatter.date(from: "2019-03-03")!,
    dateFormatter.date(from: "2019-03-04")!,
    dateFormatter.date(from: "2019-03-05")!,
    dateFormatter.date(from: "2019-03-06")!,
    dateFormatter.date(from: "2019-03-07")!,
    dateFormatter.date(from: "2019-03-08")!,
    dateFormatter.date(from: "2019-03-09")!,
    dateFormatter.date(from: "2019-03-10")!
  ]
  
  private let colors: [UIColor] = [
    UIColor(red: 108/255, green: 184/255, blue: 255/255, alpha: 1),
    UIColor(red: 1/255, green: 140/255, blue: 203/255, alpha: 1),
     UIColor(red: 105/255, green: 55/255, blue: 146/255, alpha: 1),
    UIColor(red: 0/255, green: 86/255, blue: 180/255, alpha: 1)
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nextPillDate = Date(timeIntervalSinceNow: 5000)
    
    validatedPillDates.forEach { date in
      calendarView.select(date)
    }
    
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
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 244, height: 239))
    if index == 2 {
        let checkinView = Bundle.main.loadNibNamed("CheckinView", owner: self, options: nil)?.first as? CheckinView
        checkinView?.initViews()
        view.addSubview(checkinView!)
    } else if index == 1 {
        let moodView = Bundle.main.loadNibNamed("MoodMeter", owner: self, options: nil)?.first as? MoodMeter
        moodView?.initViews()
        view.addSubview(moodView!)
    } else if index == 0 {
        let streakView = Bundle.main.loadNibNamed("Streak", owner: self, options: nil)?.first as? Streak
        view.addSubview(streakView!)
    } else if index == 3 {
        let funfactsView = Bundle.main.loadNibNamed("Funfacts", owner: self, options: nil)?.first as? Funfacts
        view.addSubview(funfactsView!)
    }
    view.layer.cornerRadius = 5
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 10
    view.layer.shadowOffset = CGSize.zero
    view.layer.shadowRadius = 1
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
  
  func carouselCurrentItemIndexDidChange(_ carousel: iCarousel!) {
    view.backgroundColor = colors[carousel.currentItemIndex]
  }
}

extension ViewController: FSCalendarDataSource {
}

extension ViewController: FSCalendarDelegate {
}
