//
//  FlashAnzanManager.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/08/29.
//

import Foundation
import AudioToolbox

protocol flashQuestionDelegate {
    func anserInputViewControllerTransition()
    func questionDisplay(displayNum: String)
    func blancDisplay()
}

class FlashAnzanManager {
    static let flashAnZanShare = FlashAnzanManager()
    var numberOfQuestion = 0
    var digit = 0
    var interval = 0.0
    var soundStatus:Bool = true
    var questionList:[Int] = []
    var anserValue = 0
    var anserJudge:Bool = true
    var timer: Timer?
    var questionNum = ""
    var flashQuestionNum = 0
    var delegate: flashQuestionDelegate?
    
    private init() {
    }
    
    func executeTimer() {
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(flashQuestionDisplay), userInfo: nil, repeats: true)
    }
    
    @objc func flashQuestionDisplay() {
        if flashQuestionNum == 0 {
            timer?.invalidate()
            delegate?.anserInputViewControllerTransition()
        } else {
            delegate?.questionDisplay(displayNum: digitNumberGenerator(digit: FlashAnzanManager.flashAnZanShare.digit))
            if FlashAnzanManager.flashAnZanShare.soundStatus == true {
                AudioServicesPlaySystemSound(1052)
            }
            questionNum.removeAll{
                $0 == ","
            }
            questionList.append(Int(questionNum) ?? 0)
            delegate?.blancDisplay()
        }
        flashQuestionNum -= 1
    }
    
    func digitNumberGenerator(digit: Int) -> String {
        let firstNum = Int.random(in: 1...9)
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
    
    func deliveryNumberOfQuestionValue() {
        flashQuestionNum = numberOfQuestion
    }
}
