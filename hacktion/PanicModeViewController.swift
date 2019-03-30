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
  
  private var messages: [Message] = [
    Message(text: "😱  Ooops...", sender: .me, possibleAnswers: nil),
    Message(text: "Hey Lola ! Don’t panic ! 😊 I will get you through the different steps", sender: .chatbot, possibleAnswers: nil),
    Message(text: "First of all, you confirm that you are taking the Yasmin combined contraceptive pill ?", sender: .chatbot, possibleAnswers: ["Yes", "No"])
  ]
  
  private var lastMessageIndex = 0
  private var animationDelay = 0.0
  private var step = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UINib(nibName: myMessageIdentifier, bundle: nil), forCellReuseIdentifier: myMessageIdentifier)
    tableView.register(UINib(nibName: chatbotMessageIdentifier, bundle: nil), forCellReuseIdentifier: chatbotMessageIdentifier)
    tableView.estimatedRowHeight = 60
    tableView.rowHeight = UITableView.automaticDimension
    
    answersStackView.isHidden = true
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
      button.backgroundColor = UIColor(red: 255/255, green: 113/255, blue: 60/255, alpha: 1)
      button.titleLabel?.font = UIFont(name: "Nunito-Bold", size: 15)
      button.layer.cornerRadius = 8
      button.addTarget(self, action: #selector(answerQuestion(_:)), for: .touchUpInside)
      answersStackView.addArrangedSubview(button)
    }
    
    answersStackView.isHidden = false
  }
  
  @objc private func answerQuestion(_ sender: UIButton) {
    answersStackView.isHidden = true
    guard let answer = sender.titleLabel?.text else {
      return
    }
    
    insertMessage(Message(text: answer, sender: .me, possibleAnswers: nil))
    displayNextChatbotMessages()
  }
  
  private func displayNextChatbotMessages() {
    step += 1
    if (step == 1) {
      insertMessage(Message(text: "Great", sender: .chatbot, possibleAnswers: nil))
      insertMessage(Message(text: "And your last period ended 3 days ago right ?", sender: .chatbot, possibleAnswers: ["Yes", "No"]))
    }
  }
  
  private func insertMessage(_ message: Message) {
    let row = tableView.numberOfRows(inSection: 0)
    messages.append(message)
    tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
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
      let cell = tableView.dequeueReusableCell(withIdentifier: chatbotMessageIdentifier, for: indexPath) as! ChatbotMessageTableViewCell
      cell.message = message.text
      return cell
    }
    return UITableViewCell()
  }
}

extension PanicModeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard indexPath.row > lastMessageIndex else {
      return
    }
    cell.transform = CGAffineTransform(translationX: 0, y: tableView.bounds.height)

    UIView.animate(
      withDuration: 1,
      delay: 0.5 * animationDelay,
      options: [.curveEaseInOut],
      animations: {
        self.animationDelay = Double(indexPath.row)
        cell.transform = CGAffineTransform(translationX: 0, y: 0)
    }, completion: { _ in
      self.animationDelay = 0.0
      self.displayPossibleAnswersForMessage(at: indexPath.row)
    })
    
    if (lastMessageIndex < indexPath.row) {
      lastMessageIndex = indexPath.row
    }
  }
}
