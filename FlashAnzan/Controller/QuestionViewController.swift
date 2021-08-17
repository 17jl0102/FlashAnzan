//
//  QuestionViewController.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/06/27.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController, UIApplicationDelegate {
    
    @IBOutlet weak var flashNumberLabel: UILabel!
    var numberOfQuestion = 0
    var digit = 0
    var interval:Double = 0
    var questionList:[Int] = []
    private var timer: Timer?
    var quesiton = 0
    var soundStatus = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(playAgain), name: Notification.Name("playAgain"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        flashNumberLabel.text = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.timer = Timer.scheduledTimer(timeInterval: self.interval, target: self, selector: #selector(self.flashQuesitonDisplay), userInfo: nil, repeats: true)
        }
        quesiton = numberOfQuestion
    }
    
    @objc func playAgain() {
        dismiss(animated: true, completion: nil)
    }

    @objc func flashQuesitonDisplay() {
        if quesiton == 0 {
            timer?.invalidate()
            let anserInputViewController = storyboard?.instantiateViewController(withIdentifier: "AnserInputViewController") as! AnserInputViewController
            anserInputViewController.quesitonList = questionList
            present(anserInputViewController, animated: true, completion: nil)
            questionList = []
            soundStatus = 0
        } else {
            flashNumberLabel.text = digitNumberGenerator(digit: digit)
            if soundStatus == 1 {
                AudioServicesPlaySystemSound(1052)
            }
            questionList.append(Int(flashNumberLabel.text ?? "") ?? 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + interval/2) {
                self.flashNumberLabel.text = ""
            }
        }
        quesiton -= 1
    }

    func digitNumberGenerator(digit: Int) -> String {
        let firstDigit = Int.random(in: 1...9)
        var questionNum = ""
        if digit == 1 {
            questionNum = String(firstDigit)
            return questionNum
        } else {
            questionNum = String(firstDigit)
            for _ in 1..<digit {
                let randomInt = Int.random(in: 0...9)
                questionNum += String(randomInt)
            }
        }
        return questionNum
    }
}
