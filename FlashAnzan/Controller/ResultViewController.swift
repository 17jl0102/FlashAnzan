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
    
    var anserValue = 0
    var questionList:[Int] = []
    var quesitonResultInt = 0
    let quesiton = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        quesitonResultLabel.text = String(quesitonResultInt)
        anserLabel.text = String(anserValue)
        if anserValue == quesitonResultInt {
            anserJudgeLabel.text = "正解です"
        } else {
            anserJudgeLabel.text = "不正解です"
        }
        
        for quesiton in questionList {
            questionLabel.text! += "\(quesiton)\n"
        }
        questionLabel.numberOfLines = 0
        questionLabel.sizeToFit()
        
    }
    
    @IBAction func DidTapPlayAgainButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("playAgain"), object: nil)
    }
    
    @IBAction func DidTapBackFlashSettingViewControllerButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("backFlashSettingViewController"), object: nil)
    }
    
}
