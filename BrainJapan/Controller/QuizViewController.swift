//
//  QuizViewController.swift
//  BrainJapan
//
//  Created by Fabian Hofer on 01.03.24.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var brainJapan = BrainJapan()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupCornerRadius(for: choice1)
        setupCornerRadius(for: choice2)
        setupCornerRadius(for: choice3)
    }
    
    @objc func updateUI() {
        questionLabel.text = brainJapan.getQuestionText()
        
        let answerChoice = brainJapan.getAnswer()
        choice1.setTitle(answerChoice[0], for: .normal)
        choice2.setTitle(answerChoice[1], for: .normal)
        choice3.setTitle(answerChoice[2], for: .normal)
        
        progressBar.progress = brainJapan.getProgress()
        scoreLabel.text =  "Score: \(brainJapan.getScore())"
        choice1.backgroundColor = UIColor.clear
        choice2.backgroundColor = UIColor.clear
        choice3.backgroundColor = UIColor.clear
    }
    
    func setupCornerRadius(for view: UIView) {
        view.layer.cornerRadius = 15
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToDashboard", sender: self)
    }
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let userGotItRight = brainJapan.checkAnswer(userAnswer)
        
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        brainJapan.nextQuizQuestion()
        
        if brainJapan.getIsQuizFinished() == true {
            showResultViewController()
        } else {
            Timer.scheduledTimer(timeInterval: 0.3, target: self,
                                 selector: #selector(updateUI),
                                 userInfo: nil, repeats: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResultView" {
            let destinationCV = segue.destination as! ResultViewController
            destinationCV.scoreValue = brainJapan.getScore()
        }
    }
    
    func showResultViewController() {
        self.performSegue(withIdentifier: "goToResultView", sender: self)
    }
}
