//
//  Question.swift
//  BrainJapan
//
//  Created by Fabian Hofer on 23.02.24.
//
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
