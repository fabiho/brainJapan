//
//  ResultViewController.swift
//  BrainJapan
//
//  Created by Fabian Hofer on 01.03.24.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultScoreLabel: UILabel!
    
    var scoreValue : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultScoreLabel.text =  "Score: \(scoreValue)"
    }
    
    @IBAction func restartPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "restartJapanQuiz", sender: self)
    }
    
    @IBAction func learnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToLearn", sender: self)
    }
}
