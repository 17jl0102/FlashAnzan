//
//  FlashAnzanManager.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/08/29.
//

import Foundation

class FlashAnzanManager {
    static let share = FlashAnzanManager()
    var numberOfQuestion = 0
    var digit = 0
    var interval = 0.0
    var soundStatus = 0
    var questionList:[Int] = []
    var anserValue = 0
    let questionViewController = QuestionViewController()
    var timer: Timer?
    
    private init() {
        questionViewController.delegate = self
    }
}
extension FlashAnzanManager: TimerDelegate {
    
    func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(QuestionViewController.flashQuesitonDisplay), userInfo: nil, repeats: true)
    }
}

