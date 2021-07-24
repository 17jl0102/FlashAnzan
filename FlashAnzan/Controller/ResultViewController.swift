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
    
    var anserValue = 0
    var questionList:[Int] = []
    var quesitonResultInt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        quesitonResultLabel.text = String(quesitonResultInt)
        anserLabel.text = String(anserValue)
        if anserValue == quesitonResultInt {
            anserJudgeLabel.text = "正解です"
        } else {
            anserJudgeLabel.text = "不正解です"
        }
    }
    
    @IBAction func DidTapPlayAgainButton(_ sender: UIButton) {
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DidTapBackFlashSettingViewButton(_ sender: UIButton) {
        presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
//        let flashSettingViewController = storyboard?.instantiateViewController(withIdentifier: "FlashSettingViewController") as! FlashSettingViewController
//        present(flashSettingViewController, animated: true, completion: nil)
    }
    
}
