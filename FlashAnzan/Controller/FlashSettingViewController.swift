//
//  ViewController.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/06/12.
//

import UIKit

class FlashSettingViewController: UIViewController {
    
    @IBOutlet weak var flashsettingView: FlashSettingView!
    
    var setNumberOfQuestion = 0
    var setDigit = 0
    var setInterval:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flashsettingView.delegate = self
    }

    @IBAction func didTapTransitionQuestionView(_ sender: UIButton) {
        let questionViewController = storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        if setNumberOfQuestion > 0, setDigit > 0 , setInterval > 0 {
            questionViewController.numberOfQuestion = setNumberOfQuestion
            questionViewController.digit = setDigit
            questionViewController.interval = setInterval
            present(questionViewController, animated: true, completion: nil)
        } else {
            alert(alertTitle: "未設定項目があります", alertMessage: "全ての値を設定してください")
        }
    }
    
    func alert(alertTitle: String, alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}

extension FlashSettingViewController: FlashValueSetDelegate {
    
    func numberOfQuestionValueCheck(numberOfQuestion: Int) {
        if numberOfQuestion > 0 {
            setNumberOfQuestion = numberOfQuestion
        } else {
            alert(alertTitle: "エラー", alertMessage: "出題数を設定してください")
        }
    }
    
    func digitValueCheck(digit: Int) {
        if digit > 0 {
            setDigit = digit
        } else {
            alert(alertTitle: "エラー", alertMessage: "桁数を設定してください")
        }
    }
    
    func intervalValueCheck(interval: Double) {
        if interval > 0 {
            setInterval = interval
        } else {
            alert(alertTitle: "エラー", alertMessage: "表示間隔を設定してください")
        }
    }
}
