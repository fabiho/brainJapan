//
//  LearnViewController.swift
//  BrainJapan
//
//  Created by Fabian Hofer on 01.03.24.
//

import UIKit

enum PanDirection {
    case unknown
    case left
    case right
}

enum QuestionCategory {
    case wissen
    case verstehen
    case verhalten
    
    func toString() -> String {
        switch self {
        case .wissen:
            return "Wissen"
        case .verhalten:
            return "Verhalten"
        case .verstehen:
            return "Verstehen"
        }
    }
}

class LearnViewController: UIViewController {
    
    @IBOutlet weak var flashCard: UIButton!
    @IBOutlet weak var nextCard: UIView!
    @IBOutlet weak var nextCard2: UIView!
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    
    var brainJapan = BrainJapan()
    var direction: PanDirection = .unknown
    var category: QuestionCategory = .verstehen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        setupShadow(for: flashCard)
        setupShadow(for: nextCard)
        setupShadow(for: nextCard2)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panHandler))
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        view.addGestureRecognizer(pan)
    }
    
    @objc func updateUI() {
        self.brainJapan.searchForNextLearnQuestion(segmentCategory: category)
        flashCard.setTitle(brainJapan.getQuestionText(), for: .normal)
    }
    
    func setupShadow(for view: UIView) {
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 8.0
        view.layer.shadowColor = UIColor.black.cgColor
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            category = .wissen
            updateUI()
        case 1:
            category = .verstehen
            updateUI()
        case 2:
            category = .verhalten
            updateUI()
        default:
            break
        }
    }
    
    
    @IBAction func backToDashboard(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToDashboard", sender: self)
    }
    
    @IBAction func flashcardPressed(_ sender: UIButton) {
        // Nach korrekter Antwort suchen, Text und Farbe ändern und Flip Animation
        if flashCard.titleLabel?.text ==  brainJapan.getQuestionText() {
            flashCard.setTitle(brainJapan.getCorrectAnswer(), for: .normal)
            flashCard.backgroundColor = UIColor.systemMint
            
            UIView.transition(with: sender, duration: 0.4, options: .transitionFlipFromLeft, animations: {
                sender.transform = CGAffineTransform(scaleX: -1, y: 1)
                sender.transform = .identity
            })
        } else if flashCard.titleLabel?.text ==  brainJapan.getCorrectAnswer() {
            flashCard.setTitle(brainJapan.getQuestionText(), for: .normal)
            flashCard.backgroundColor = UIColor.systemIndigo
            
            UIView.transition(with: sender, duration: 0.4, options: .transitionFlipFromLeft, animations: {
                sender.transform = CGAffineTransform(scaleX: -1, y: 1)
                sender.transform = .identity
            })
        }
    }
    
    @objc func panHandler(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began, .changed:
            
            let offset = gesture.translation(in: gesture.view)
            
            if offset.x == 0 {
                direction = .unknown
            } else {
                direction = offset.x > 0 ? .right : .left
            }
            
            if direction == .right {
                let right = offset.x
                let angleDeg = min(right / flashCard.bounds.size.width * 90, 75)
                let shift = CGAffineTransform(translationX: flashCard.bounds.size.width / 2, y: flashCard.bounds.size.height / 2)
                flashCard.transform = shift.rotated(by: angleDeg / 180 * .pi).translatedBy(x: -flashCard.bounds.size.width / 2, y: -flashCard.bounds.size.height / 2)
                
            } else if direction == .left {
                let left = offset.x
                let angleDeg = max(left / flashCard.bounds.size.width * 90, -75)
                let shift = CGAffineTransform(translationX: -flashCard.bounds.size.width / 2, y: flashCard.bounds.size.height / 2)
                flashCard.transform = shift.rotated(by: angleDeg / 180 * .pi).translatedBy(x: flashCard.bounds.size.width / 2, y: -flashCard.bounds.size.height / 2)
            }
            
        case .ended:
            if direction == .left {
                self.brainJapan.searchForLastLearnQuestion(segmentCategory: category)
            } else if direction == .right {
                self.brainJapan.searchForNextLearnQuestion(segmentCategory: category)
            }
            
            flashCard.setTitle(brainJapan.getQuestionText(), for: .normal)
            
            // Setzt die View wieder zurück auf die ursprüngliche Position
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
                self.flashCard.center = self.view.center
                self.flashCard.transform = .identity
                self.flashCard.frame.origin.x = 6
                self.flashCard.frame.origin.y = 33
            }
            direction = .unknown
            flashCard.backgroundColor = UIColor.systemIndigo
            
        default:
            break
            
        }
    }
}
