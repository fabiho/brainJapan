//
//  ViewController.swift
//  BrainJapan
//
//  Created by Fabian Hofer on 23.02.24.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var lernenButton: UIButton!
    @IBOutlet weak var japanQuizButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func lernenPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToLearn", sender: self)
    }
    
    @IBAction func japanQuizPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToJapanQuiz", sender: self)
    }
}

