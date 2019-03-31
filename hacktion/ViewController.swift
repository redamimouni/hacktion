//
//  ViewController.swift
//  hacktion
//
//  Created by reda.mimouni on 29/03/2019.
//  Copyright © 2019 OCTO Technology. All rights reserved.
//

import UIKit
import FSCalendar
import iCarousel
import Lottie

class ViewController: UIViewController {

private var transition: CardTransition?
    
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
  
  private var validatedPillDates: [Date] = [
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
    dateFormatter.date(from: "2019-03-16")!,
    dateFormatter.date(from: "2019-03-17")!,
    dateFormatter.date(from: "2019-03-18")!,
    dateFormatter.date(from: "2019-03-19")!,
    dateFormatter.date(from: "2019-03-20")!,
    dateFormatter.date(from: "2019-03-21")!,
    dateFormatter.date(from: "2019-03-22")!,
    dateFormatter.date(from: "2019-03-23")!,
    dateFormatter.date(from: "2019-03-24")!,
    dateFormatter.date(from: "2019-03-25")!,
    dateFormatter.date(from: "2019-03-26")!,
    dateFormatter.date(from: "2019-03-27")!,
    dateFormatter.date(from: "2019-03-28")!,
    dateFormatter.date(from: "2019-03-29")!,
    dateFormatter.date(from: "2019-03-30")!
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
    UIColor(red: 255/255, green: 113/255, blue: 60/255, alpha: 1),
     UIColor(red: 105/255, green: 55/255, blue: 146/255, alpha: 1)
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
    
    func showHey() {
        let checkinView = Bundle.main.loadNibNamed("CheckinView", owner: self, options: nil)?.first as? CheckinView
        checkinView?.initViews(delegate: self)
        checkinView?.tag = 999
        self.view.addSubview(checkinView!)
    }
    
    func hideView() {
        let view = self.view.viewWithTag(999)
        view?.removeFromSuperview()
    }
    
    func hellYeah() {
        validatedPillDates.append(ViewController.dateFormatter.date(from: "2019-03-31")!)
        self.nextPillDate = Date(timeIntervalSinceNow: 86400)
        self.calendarView.reloadData()
        let view = self.view.viewWithTag(999)
        view?.removeFromSuperview()
    }
    
    func showPanicMode() {
        let panicVc = storyboard?.instantiateViewController(withIdentifier: "panicvc")
        self.present(panicVc!, animated: true, completion: nil)
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
        let panicButtonView = Bundle.main.loadNibNamed("PanicButton", owner: self, options: nil)?.first as? PanicButton
        let panicVc = storyboard?.instantiateViewController(withIdentifier: "panicvc")
        panicButtonView?.addTapGestureRecognizer(action: {
            self.present(panicVc!, animated: true, completion: nil)
        })
        itemView.addSubview(panicButtonView!)
    } else if index == 1 {
        let moodView = Bundle.main.loadNibNamed("MoodMeter", owner: self, options: nil)?.first as? MoodMeter
        moodView?.initViews()
        itemView.addSubview(moodView!)
    } else if index == 0 {
        let streakView = Bundle.main.loadNibNamed("Streak", owner: self, options: nil)?.first as? BaseView
        itemView.addSubview(streakView!)
    } else if index == 3 {
        let funfactsView = Bundle.main.loadNibNamed("Funfacts", owner: self, options: nil)?.first as? BaseView
        funfactsView?.addTapGestureRecognizer(action: {
            self.animate(view: funfactsView!)
        })
        itemView.addSubview(funfactsView!)
    }
    itemView.layer.cornerRadius = 5
    itemView.layer.shadowColor = UIColor.black.cgColor
    itemView.layer.shadowOpacity = 10
    itemView.layer.shadowOffset = CGSize.zero
    itemView.layer.shadowRadius = 1
    return itemView
  }
    
    func animate(view: BaseView) {
        view.freezeAnimations()
        let currentCellFrame = view.layer.presentation()!.frame
        let cardPresentationFrameOnScreen = view.superview!.convert(currentCellFrame, to: nil)
        let cardFrameWithoutTransform = { () -> CGRect in
            let center = view.center
            let size = view.bounds.size
            let r = CGRect(
                x: center.x - size.width / 2,
                y: center.y - size.height / 2,
                width: size.width,
                height: size.height
            )
            return view.superview!.convert(r, to: nil)
        }()
        let vc = storyboard!.instantiateViewController(withIdentifier: "cardDetailVc") as! CardDetailViewController
        //vc.cardViewModel = cardModel.highlightedImage()
        //vc.unhighlightedCardViewModel = cardModel // Keep the original one to restore when dismiss
        let params = CardTransition.Params(fromCardFrame: cardPresentationFrameOnScreen,
                                           fromCardFrameWithoutTransform: cardFrameWithoutTransform,
                                           fromCell: view)
        transition = CardTransition(params: params)
        vc.transitioningDelegate = transition
        
        // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.modalPresentationStyle = .custom
        
        present(vc, animated: true, completion: { [unowned view] in
            // Unfreeze
            view.unfreezeAnimations()
        })
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
