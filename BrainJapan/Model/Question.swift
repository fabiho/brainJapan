//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Fabian Hofer on 02.02.24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    let text : String
    let answer : [String]
    let rightAnswer : String
    let category : String
    
    init(c: String, q: String, a: [String], correctAnswer: String) {
        self.category = c 
        self.text = q
        self.answer = a
        self.rightAnswer = correctAnswer
    }
}
