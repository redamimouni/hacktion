//
//  PanicModeViewController.swift
//  Pilyumi
//
//  Created by Mégane Menanteau on 30/03/2019.
//  Copyright © 2019 OCTO Technology. All rights reserved.
//

import UIKit

class PanicModeViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var answersStackView: UIStackView!
  
  private let myMessageIdentifier = "MyMessageTableViewCell"
  private let chatbotMessageIdentifier = "ChatbotMessageTableViewCell"
  private let locationMessageIdentifier = "LocationMessageTableViewCell"
  
  private var messages: [Message] = [
    Message(text: "😱  Ooops...", sender: .me, possibleAnswers: nil)
  ]
  
  private var numberOfNewMessages = 0
  private var stepLastMessageIndex = 0
  private var lastMessageIndex = 0
  private var step = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UINib(nibName: myMessageIdentifier, bundle: nil), forCellReuseIdentifier: myMessageIdentifier)
    tableView.register(UINib(nibName: chatbotMessageIdentifier, bundle: nil), forCellReuseIdentifier: chatbotMessageIdentifier)
    tableView.register(UINib(nibName: locationMessageIdentifier, bundle: nil), forCellReuseIdentifier: locationMessageIdentifier)
    tableView.estimatedRowHeight = 60
    tableView.rowHeight = UITableView.automaticDimension
    tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 80))
    
    hideAnswers()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    displayNextChatbotMessages()
  }
  
  private func showAnswers() {
    answersStackView.alpha = 0
    UIView.animate(withDuration: 0.2) {
      self.answersStackView.alpha = 1
    }
  }
  
  private func hideAnswers() {
    answersStackView.alpha = 1
    UIView.animate(withDuration: 0.2) {
      self.answersStackView.alpha = 0
    }
  }
  
  private func displayPossibleAnswersForMessage(at index: Int) {
    guard let answers = messages[index].possibleAnswers else {
      return
    }
    answersStackView.removeAllArrangedSubviews()
    
    answers.forEach { answer in
      let button = UIButton(frame: CGRect(x: 0, y: 0, width: answersStackView.bounds.width, height: answersStackView.bounds.height))
      button.setTitle(answer, for: .normal)
      button.setTitleColor(.white, for: .normal)
      button.backgroundColor = answer == "Yes" ? UIColor(red: 86/255, green: 205/255, blue: 113/255, alpha: 1) : UIColor(red: 255/255, green: 113/255, blue: 60/255, alpha: 1)
      button.titleLabel?.font = UIFont(name: "Nunito-Bold", size: 15)
      button.layer.cornerRadius = 8
      button.addTarget(self, action: #selector(answerQuestion(_:)), for: .touchUpInside)
      answersStackView.addArrangedSubview(button)
    }
    
    showAnswers()
  }
  
  @objc private func answerQuestion(_ sender: UIButton) {
    hideAnswers()
    guard let answer = sender.titleLabel?.text else {
      return
    }
    
    insertMessages([Message(text: answer, sender: .me, possibleAnswers: nil)])
    
    Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(displayNextChatbotMessages), userInfo: nil, repeats: false)
  }
  
  @objc private func displayNextChatbotMessages() {
    var messages: [Message] = []
    
    step += 1
    if (step == 1) {
      messages = [
        Message(text: "Hey Lola ! Don’t panic ! 😊\nI will get you through the different steps", sender: .chatbot, possibleAnswers: nil),
        Message(text: "First of all, you confirm that you are taking the Yasmin combined contraceptive pill ?", sender: .chatbot, possibleAnswers: ["Yes", "No"])
      ]
    } else if (step == 2) {
      messages = [
        Message(text: "Great", sender: .chatbot, possibleAnswers: nil),
        Message(text: "And your last period ended 3 days ago right ?", sender: .chatbot, possibleAnswers: ["Yes", "No"])
      ]
    } else if (step == 3) {
      messages = [
        Message(text: "So how many pill did you forget to take ?", sender: .chatbot, possibleAnswers: ["1", "2", "3", "more"])
      ]
    } else if (step == 4) {
      messages = [
        Message(text: "Okay Lola, take yersterday’s pill as soon as possible, even if you have to take 2 today", sender: .chatbot, possibleAnswers: nil),
        Message(text: "Continue taking your pills normally", sender: .chatbot, possibleAnswers: nil),
        Message(text: "However, for 7 days, you are not protected. So use condoms if you are having sex, OK?  😊", sender: .chatbot, possibleAnswers: nil),
        Message(text: "Now... when was the last time you had sex ?", sender: .chatbot, possibleAnswers: ["1-2 days", "< 7 days", "> 7 days"])
      ]
    } else if (step == 5) {
      messages = [
        Message(text: "Lola, I’m sorry but there is a chance you could be pregnant", sender: .chatbot, possibleAnswers: nil),
        Message(text: "The best thing to do now is to take the morning after pill as soon as possible", sender: .chatbot, possibleAnswers: nil),
        Message(text: "Do you want to know where is the closest, open pharmacy ?", sender: .chatbot, possibleAnswers: ["Yes", "No"])
      ]
    } else if (step == 6) {
      messages = [
        Message(text: "Ma pharmacie\n1 rue des Tournelles, 75004", sender: .chatbot, type: .location, possibleAnswers: nil),
        Message(text: "If you want to talk to someone about the morning after pill, call 0 800 881 755", sender: .chatbot, possibleAnswers: nil)
      ]
    }
    
    numberOfNewMessages = messages.count
    insertMessages(messages)
    stepLastMessageIndex += numberOfNewMessages
  }
  
  private func insertMessages(_ messages: [Message]) {
    messages.forEach { message in
      let row = tableView.numberOfRows(inSection: 0)
      let indexPath = IndexPath(row: row, section: 0)
      self.messages.append(message)
      tableView.insertRows(at: [indexPath], with: .automatic)
      UIView.animate(
        withDuration: 1,
        delay: 0.5,
        options: [.curveEaseInOut],
        animations: {
          self.tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
      })
    }
  }
  
  @IBAction func close() {
    dismiss(animated: true, completion: nil)
  }
}

extension PanicModeViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let message = messages[indexPath.row]
    if (message.sender == .me) {
      let cell = tableView.dequeueReusableCell(withIdentifier: myMessageIdentifier, for: indexPath) as! MyMessageTableViewCell
      cell.message = message.text
      return cell
    } else if (message.sender == .chatbot) {
      if (message.type == .text) {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatbotMessageIdentifier, for: indexPath) as! ChatbotMessageTableViewCell
        cell.message = message.text
        return cell
      } else if (message.type == .location) {
        let cell = tableView.dequeueReusableCell(withIdentifier: locationMessageIdentifier, for: indexPath) as! LocationMessageTableViewCell
        cell.message = message.text
        return cell
      }
    }
    return UITableViewCell()
  }
}

extension PanicModeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard indexPath.row > lastMessageIndex else {
      return
    }
    let delay = cell is MyMessageTableViewCell ? 0.0 : Double(indexPath.row - stepLastMessageIndex - 1)
    cell.transform = CGAffineTransform(translationX: 0, y: tableView.bounds.height)

    UIView.animate(
      withDuration: 1,
      delay: 0.5 * delay,
      options: [.curveEaseInOut],
      animations: {
        cell.transform = CGAffineTransform(translationX: 0, y: 0)
    }, completion: { _ in
      self.displayPossibleAnswersForMessage(at: indexPath.row)
    })
    
    if (lastMessageIndex < indexPath.row) {
      lastMessageIndex = indexPath.row
    }
  }
}
