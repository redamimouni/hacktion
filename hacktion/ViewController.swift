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
    dateFormatter.date(from: "2019-03-15")!,
    dateFormatter.date(from: "2019-03-16")!
  ]
  private let menstruationDates: [Date] = [
    dateFormatter.date(from: "2019-03-10")!,
    dateFormatter.date(from: "2019-03-11")!,
    dateFormatter.date(from: "2019-03-12")!,
    dateFormatter.date(from: "2019-03-13")!,
    dateFormatter.date(from: "2019-03-14")!
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
    
    calendarView.appearance.headerTitleFont = UIFont(name: "Nunito-ExtraBold", size: 20)
    calendarView.appearance.weekdayFont = UIFont(name: "Nunito-Bold", size: 12)
    calendarView.appearance.titleFont = UIFont(name: "Nunito-Bold", size: 12)
    calendarView.clipsToBounds = true
    
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
    if index == 2 {
        let checkinView = Bundle.main.loadNibNamed("CheckinView", owner: self, options: nil)?.first as? CheckinView
        checkinView?.initViews()
        itemView.addSubview(checkinView!)
    } else if index == 1 {
        let moodView = Bundle.main.loadNibNamed("MoodMeter", owner: self, options: nil)?.first as? MoodMeter
        moodView?.initViews()
        itemView.addSubview(moodView!)
    } else if index == 0 {
        let streakView = Bundle.main.loadNibNamed("Streak", owner: self, options: nil)?.first as? Streak
        itemView.addSubview(streakView!)
    } else if index == 3 {
        let funfactsView = Bundle.main.loadNibNamed("Funfacts", owner: self, options: nil)?.first as? Funfacts
        itemView.addSubview(funfactsView!)
    }
    itemView.layer.cornerRadius = 5
    itemView.layer.shadowColor = UIColor.black.cgColor
    itemView.layer.shadowOpacity = 10
    itemView.layer.shadowOffset = CGSize.zero
    itemView.layer.shadowRadius = 1
    return itemView
  }
}

extension ViewController: iCarouselDelegate {
  func carousel(_ carousel: iCarousel!, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
    if option == .spacing {
      return value * 1.07
    }
    return value
  }
  
  func carouselCurrentItemIndexDidChange(_ carousel: iCarousel!) {
    view.backgroundColor = colors[carousel.currentItemIndex]
  }
}

extension ViewController: FSCalendarDataSource {
  func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
    return Calendar.current.isDate(date, inSameDayAs: Date()) ? 1 : 0
  }
}

extension ViewController: FSCalendarDelegate {
  func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
    if (validatedPillDates.contains(date)) {
      cell.shapeLayer.fillColor = UIColor(red: 86/255, green: 205/255, blue: 113/255, alpha: 1).cgColor
    } else if (menstruationDates.contains(date)) {
      cell.shapeLayer.fillColor = UIColor.red.cgColor
    }
  }
}
