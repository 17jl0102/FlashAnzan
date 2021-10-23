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
    
    var quesitonResultInt = FlashAnzanManager.Shared.questionList.reduce(0){$0 + $1}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quesitonResultLabel.text = String(quesitonResultInt)
        anserLabel.text = String(FlashAnzanManager.Shared.anserValue)
        if FlashAnzanManager.Shared.anserValue == quesitonResultInt {
            anserJudgeLabel.text = "正解です"
            FlashAnzanManager.Shared.anserJudge = true
        } else {
            anserJudgeLabel.text = "不正解です"
            FlashAnzanManager.Shared.anserJudge = false
        }
        
        for quesiton in FlashAnzanManager.Shared.questionList {
            questionLabel.text! += "\(quesiton)\n"
        }
        
        FlashAnzanManager.Shared.saveResume()
    }
    
    @IBAction func DidTapPlayAgainButton(_ sender: UIButton) {
        FlashAnzanManager.Shared.questionList = []
        NotificationCenter.default.post(name: Notification.Name.playAgain, object: nil)
    }
    
    @IBAction func DidTapBackFlashSettingViewControllerButton(_ sender: UIButton) {
        FlashAnzanManager.Shared.questionList = []
        NotificationCenter.default.post(name: Notification.Name.backFlashSettingViewController, object: nil)
    }
    
}
