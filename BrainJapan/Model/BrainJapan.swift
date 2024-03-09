//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by Fabian Hofer on 09.02.24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct BrainJapan {
    let quiz = [
        Question(c: "Verstehen", q: "Was bedeutet こんにちは (Kon'nichiwa)?", a: ["Guten Abend", "Guten Tag", "Auf Wiedersehen"], correctAnswer: "Guten Tag"),
        Question(c: "Verhalten",q: "Wie fragt man in Japan nach der Rechnung?", a: ["Watashi wa owatta", "Go chūmon kudasai", "o-kanjo kudasai"], correctAnswer: "o-kanjo kudasai"),
        Question(c: "Wissen",q: "Welchen Namen trägt die Nordinsel Japans?", a: ["Honshu", "Kyushu", "Hokkaido"], correctAnswer: "Hokkaido"),
        Question(c: "Verstehen",q: "Was bedeutet じてんしゃ (jitensha)?", a: ["Auto", "Taxi", "Fahrrad"], correctAnswer: "Fahrrad"),
        Question(c: "Wissen",q: "Wo liegt Japans Hauptstadt Tokio?", a: ["an der Nordspitze des Landes", "auf der Hauptinsel Honshu", "an der Südspitze des Landes"], correctAnswer: "auf der Hauptinsel Honshu"),
        Question(c: "Verhalten",q: "Warum haben einige Sitze in Bussen und Bahnen eine andere Farbe?", a: ["Werbegag von Coca-Cola", "Sie sind für ältere Menschen", "Sie sind reservierungspflichtig"], correctAnswer: "Sie sind für ältere Menschen"),
        Question(c: "Wissen",q: "Japan ist ein Inselstaat in?", a: ["Westasien", "Südostasien", "Ostasien"], correctAnswer: "Ostasien"),
        Question(c: "Verhalten",q: "Wie viel Trinkgeld wird in Japan erwartet?", a: ["Kein Trinkgeld", "Fünf Prozent", "Zehn Prozent"], correctAnswer: "Kein Trinkgeld"),
        Question(c: "Wissen",q: "In Japan leben rund?", a: ["100 Mio. Menschen", "110 Mio. Menschen", "130 Mio. Menschen"], correctAnswer: "130 Mio. Menschen"),
        Question(c: "Verhalten",q: "Was sind passende Gastgeschenke in Japan?", a: ["Vier weiße Blumen", "Scheren", "Typisch deutscher Kitsch"], correctAnswer: "Typisch deutscher Kitsch"),
        Question(c: "Wissen",q: "Welchen Herrschertitel trägt der japanische Kaiser", a: ["Shōgun", "Tennō", "Sultan"], correctAnswer: "Tennō"),
        Question(c: "Verstehen",q: "Was bedeutet おげんきですか (O genki desu ka)?", a: ["Wie geht es Ihnen", "Ich verstehe", "Nein Danke"], correctAnswer: "Wie geht es Ihnen"),
        Question(c: "Wissen",q: "Welche Religion wird fast ausschließlich in Japan praktiziert?", a: ["Buddhismus", "Daoismus", "Shintoismus"], correctAnswer: "Shintoismus"),
        Question(c: "Verhalten",q: "Was solltest du auf gar keinen Fall beim Essen mit Stäbchen tun?", a: ["Stäbchen kreuzen", "Ein Stäbchen in jede Hand", "Aufrecht in den Reis stecken"], correctAnswer: "Aufrecht in den Reis stecken"),
        Question(c: "Verstehen",q: "Was bedeutet すみません (Sumimasen)?", a: ["Bitte", "Vielen Dank", "Entschuldigung"], correctAnswer: "Entschuldigung"),
        Question(c: "Verstehen",q: "Was bedeutet ありがとう (Arigatō)?", a: ["Danke", "Bitte", "Entschuldigung"], correctAnswer: "Danke"),
        Question(c: "Verhalten",q: "Was sollte man in Japan immer unbedingt bei sich haben?", a: ["Pfefferspray", "Essstäbchen", "Visitenkarten"], correctAnswer: "Visitenkarten"),
        Question(c: "Wissen",q: "Wie heißt der Kugelfisch, der in Japan eine gefährliche Delikatesse ist?", a: ["Sashimi", "Fugu", "Shiitake"], correctAnswer: "Fugu"),
        Question(c: "Wissen",q: "Für was steht der Fuchs in Japan?", a: ["Freundschaft", "Hinterhältigkeit", "Wohlstand"], correctAnswer: "Hinterhältigkeit"),Question(c: "Wissen",q: "Was macht eine Geräuschprinzessin (Otohime) in Japan?", a: ["Tiergeräusche nachahmen", "Toilettengeräusche übertönen", "Gäste mit Musik unterhalten"], correctAnswer: "Toilettengeräusche übertönen"),
        Question(c: "Verstehen",q: "Was bedeutet まち の ちゅしん (machi no chushin)?", a: ["Hotel", "Bank", "Stadtzentrum"], correctAnswer: "Stadtzentrum")
    ]
    
    var questionNumber = 0
    var score = 0
    var isQuizFinished = false
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if userAnswer == quiz[questionNumber].rightAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    mutating func nextQuizQuestion() {
        if questionNumber + 1 < quiz.count {
            questionNumber += 1
        } else {
            isQuizFinished = true
        }
    }
    
    mutating func lastQuizQuestion() {
        if questionNumber == 0 {
            questionNumber = 0
            score = 0
        } else {
            questionNumber -= 1
        }
    }
    
    mutating func searchForNextLearnQuestion(segmentCategory: QuestionCategory) {
        var startingIndex = questionNumber + 1
        
        while startingIndex != questionNumber {
            if startingIndex >= quiz.count {
                startingIndex = 0
            } else {
                if quiz[startingIndex].category == segmentCategory.toString() {
                    questionNumber = startingIndex
                } else {
                    startingIndex += 1
                }
            }
        }
    }
    
    mutating func searchForLastLearnQuestion(segmentCategory: QuestionCategory) {
        var startingIndex = questionNumber - 1
        
        while startingIndex != questionNumber {
            if startingIndex <= 0 {
                startingIndex = quiz.count - 1
            } else {
                if quiz[startingIndex].category == segmentCategory.toString() {
                    questionNumber = startingIndex
                } else {
                    startingIndex -= 1
                }
            }
        }
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getIsQuizFinished() -> Bool {
        return isQuizFinished
    }
    
    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    
    func getAnswer() -> [String] {
        return quiz[questionNumber].answer
    }
    
    func getCorrectAnswer() -> String {
        return quiz[questionNumber].rightAnswer
    }
    
    func getProgress() -> Float {
        let progress = Float(questionNumber + 1) / Float(quiz.count)
        return progress
    }
}
