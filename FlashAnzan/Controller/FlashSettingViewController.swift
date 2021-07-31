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
        if setNumberOfQuestion > 0, setDigit > 0 , setInterval > 0 {
            questionViewController.numberOfQuestion = setNumberOfQuestion
            questionViewController.digit = setDigit
            questionViewController.interval = setInterval
            questionViewController.soundStatus = soundStatus
            present(questionViewController, animated: true, completion: nil)
            soundStatus = 0
        } else {
            alert(alertTitle: "未設定項目があります", alertMessage: "全ての値を設定してください")
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
    
    func numberOfQuestionValueCheck(numberOfQuestion: Int) {
        if numberOfQuestion > 1 && numberOfQuestion <= 100 {
            setNumberOfQuestion = numberOfQuestion
        } else {
            alert(alertTitle: "エラー", alertMessage: "2~100問内で設定してください")
        }
    }
    
    func digitValueCheck(digit: Int) {
            setDigit = digit
    }
    
    func intervalValueCheck(interval: Double) {
        if interval >= 0.1 && interval <= 3 {
            setInterval = interval
        } else {
            alert(alertTitle: "エラー", alertMessage: "0001~3000ミリ秒内で設定してください")
        }
    }
}
