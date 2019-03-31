//
//  Message.swift
//  Pilyumi
//
//  Created by Mégane Menanteau on 30/03/2019.
//  Copyright © 2019 OCTO Technology. All rights reserved.
//

import Foundation

struct Message {
  let text: String
  let sender: MessageSender
  let type: MessageType
  let possibleAnswers: [String]?
  
  init(text: String,
       sender: MessageSender,
       type: MessageType = .text,
       possibleAnswers: [String]? = nil) {
    self.text = text
    self.sender = sender
    self.type = type
    self.possibleAnswers = possibleAnswers
  }
}
