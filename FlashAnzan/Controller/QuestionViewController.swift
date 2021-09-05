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

    private var timer: Timer?
    var quesiton = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(playAgain), name: Notification.Name("playAgain"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        flashNumberLabel.text = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.timer = Timer.scheduledTimer(timeInterval: FlashAnzanManager.share.interval, target: self, selector: #selector(self.flashQuesitonDisplay), userInfo: nil, repeats: true)
        }
        quesiton = FlashAnzanManager.share.numberOfQuestion
    }
    
    @objc func playAgain() {
        dismiss(animated: true, completion: nil)
    }

    @objc func flashQuesitonDisplay() {
        if quesiton == 0 {
            timer?.invalidate()
            let anserInputViewController = storyboard?.instantiateViewController(withIdentifier: "AnserInputViewController") as! AnserInputViewController
            present(anserInputViewController, animated: true, completion: nil)
        } else {
            var deleateCommmaNum: String
            flashNumberLabel.text = digitNumberGenerator(digit: FlashAnzanManager.share.digit)
            if FlashAnzanManager.share.soundStatus == 1 {
                AudioServicesPlaySystemSound(1052)
            }
            deleateCommmaNum = flashNumberLabel.text ?? ""
            deleateCommmaNum.removeAll{
                $0 == ","
            }
            FlashAnzanManager.share.questionList.append(Int(deleateCommmaNum) ?? 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + FlashAnzanManager.share.interval/2) {
                self.flashNumberLabel.text = ""
            }
        }
        quesiton -= 1
    }

    func digitNumberGenerator(digit: Int) -> String {
        let firstNum = Int.random(in: 1...9)
        var questionNum = ""
        if digit == 1 {
            questionNum = String(firstNum)
            return questionNum
        } else {
            var num = String(firstNum)
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = ","
            formatter.groupingSize = 3
            
            for _ in 1..<digit {
                let randomNum = Int.random(in: 0...9)
                num += String(randomNum)
            }
            questionNum = formatter.string(from: NSNumber(value: Int(num) ?? 0)) ?? ""
        }
        return questionNum
    }
}
