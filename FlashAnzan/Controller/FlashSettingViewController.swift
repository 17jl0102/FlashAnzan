//
//  ViewController.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/06/12.
//

import UIKit

class FlashSettingViewController: UIViewController {
    
    @IBOutlet weak var flashsettingView: FlashSettingView!
    @IBOutlet weak var soundControlButoon: UIButton!
    
    var setNumberOfQuestion = 0
    var setDigit = 0
    var setInterval:Double = 0
    var soundStatus = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flashsettingView.delegate = self
        soundControlButoon.setTitle("音 有", for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(backFlashSettingViewController), name: Notification.Name("backFlashSettingViewController"), object: nil)
        
        
    }
    
    @objc func backFlashSettingViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func alert(alertTitle: String, alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    @IBAction func didTapTransitionQuestionView(_ sender: UIButton) {
        let questionViewController = storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        numberOfQuestionCheckAlert()
        digitCheckAlert()
        intervalCheckAlert()
        if setNumberOfQuestion >= 2 && setNumberOfQuestion <= 100, setDigit >= 1 && setDigit <= 5, setInterval >= 0.1 && setInterval <= 3 {
            questionViewController.numberOfQuestion = setNumberOfQuestion
            questionViewController.digit = setDigit
            questionViewController.interval = setInterval
            questionViewController.soundStatus = soundStatus
            present(questionViewController, animated: true, completion: nil)
            soundStatus = 0
        }
    }
    
    @IBAction func didTapSoundControl(_ sender: UIButton) {
        if soundStatus == 0 {
            soundStatus = 1
            soundControlButoon.setTitle("音 無", for: .normal)
        } else {
            soundStatus = 0
            soundControlButoon.setTitle("音 有", for: .normal)
        }
    }
}

extension FlashSettingViewController: FlashValueSetDelegate {
    func numberOfQuestionValueDelivery(numberOfQuestion: Int) {
        setNumberOfQuestion = numberOfQuestion
    }
    
    func digitValueDelivery(digit: Int) {
        setDigit = digit
    }
    
    func intervalValueDelivery(interval: Double) {
        setInterval = Double(interval) / 1000
    }
    
    func numberOfQuestionCheckAlert() {
        if setNumberOfQuestion == 0 {
            alert(alertTitle: "入力エラー", alertMessage: "問題数を設定してください")
        } else if setNumberOfQuestion <= 1 || setNumberOfQuestion > 100  {
            alert(alertTitle: "条件エラー", alertMessage: "2~100問内で設定してください")
        }
    }
    
    func digitCheckAlert() {
        if setDigit == 0 {
            alert(alertTitle: "入力エラー", alertMessage: "桁数をを設定してください")
        }
    }
    
    func intervalCheckAlert() {
        if setInterval == 0 {
            alert(alertTitle: "入力エラー", alertMessage: "表示間隔を設定してください")
        } else if setInterval < 0.1 || setInterval > 3 {
            alert(alertTitle: "条件エラー", alertMessage: "100~3000ミリ秒内で設定してください")
        }
    }
}
