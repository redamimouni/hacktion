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
  
  private let myMessageIdentifier = "MyMessageTableViewCell"
  private let chatbotMessageIdentifier = "ChatbotMessageTableViewCell"
  
  private let messages: [Message] = [
    Message(text: "😱  Ooops...", sender: .me),
    Message(text: "Hey Lola ! Don’t panic ! 😊 I will get you through the different steps", sender: .chatbot),
    Message(text: "First of all, you confirm that you are taking the Yasmin combined contraceptive pill ?", sender: .chatbot)
  ]
  
  private var lastMessageIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UINib(nibName: myMessageIdentifier, bundle: nil), forCellReuseIdentifier: myMessageIdentifier)
    tableView.register(UINib(nibName: chatbotMessageIdentifier, bundle: nil), forCellReuseIdentifier: chatbotMessageIdentifier)
    tableView.estimatedRowHeight = 60
    tableView.rowHeight = UITableView.automaticDimension
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
      delay: 0.5 * Double(indexPath.row),
      options: [.curveEaseInOut],
      animations: {
        cell.transform = CGAffineTransform(translationX: 0, y: 0)
    })
    
    if (lastMessageIndex < indexPath.row) {
      lastMessageIndex = indexPath.row
    }
  }
}
