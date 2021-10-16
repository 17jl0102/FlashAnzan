//
//  resultViewController.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/07/18.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var anserJudgeLabel: UILabel!
    @IBOutlet weak var quesitonResultLabel: UILabel!
    @IBOutlet weak var anserLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    var quesitonResultInt = FlashAnzanManager.flashAnZanShare.questionList.reduce(0){$0 + $1}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quesitonResultLabel.text = String(quesitonResultInt)
        anserLabel.text = String(FlashAnzanManager.flashAnZanShare.anserValue)
        if FlashAnzanManager.flashAnZanShare.anserValue == quesitonResultInt {
            anserJudgeLabel.text = "正解です"
            FlashAnzanManager.flashAnZanShare.anserJudge = true
        } else {
            anserJudgeLabel.text = "不正解です"
            FlashAnzanManager.flashAnZanShare.anserJudge = false
        }
        
        for quesiton in FlashAnzanManager.flashAnZanShare.questionList {
            questionLabel.text! += "\(quesiton)\n"
        }
        
        let result = Resume(numberOfQuestion: FlashAnzanManager.flashAnZanShare.numberOfQuestion, digit: FlashAnzanManager.flashAnZanShare.digit, interval: FlashAnzanManager.flashAnZanShare.interval, anserJudge: FlashAnzanManager.flashAnZanShare.anserJudge)
        ResumeManager.addResumes(resume: result)
    }
    
    @IBAction func DidTapPlayAgainButton(_ sender: UIButton) {
        FlashAnzanManager.flashAnZanShare.questionList = []
        NotificationCenter.default.post(name: Notification.Name.playAgain, object: nil)
    }
    
    @IBAction func DidTapBackFlashSettingViewControllerButton(_ sender: UIButton) {
        FlashAnzanManager.flashAnZanShare.questionList = []
        NotificationCenter.default.post(name: Notification.Name.backFlashSettingViewController, object: nil)
    }
    
}
