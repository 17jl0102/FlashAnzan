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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flashsettingView.delegate = self
        
        soundControlButoon.setTitle("音 有", for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(backFlashSettingViewController),
                                               name: Notification.Name.backFlashSettingViewController, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resumePlay), name: .resumePlay, object: nil)
    }
    
    @objc func backFlashSettingViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func resumePlay() {
        dismiss(animated: true, completion: nil)
        let questionViewController = storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        present(questionViewController, animated: true, completion: nil)
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
        if FlashAnzanManager.Shared.numberOfQuestion >= 2 && FlashAnzanManager.Shared.numberOfQuestion <= 100, FlashAnzanManager.Shared.digit >= 1 && FlashAnzanManager.Shared.digit <= 5, FlashAnzanManager.Shared.interval >= 0.1 && FlashAnzanManager.Shared.interval <= 3 {
            present(questionViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapSoundControl(_ sender: UIButton) {
        if FlashAnzanManager.Shared.soundStatus == true {
            FlashAnzanManager.Shared.soundStatus.toggle()
            soundControlButoon.setTitle("音 無", for: .normal)
        } else {
            FlashAnzanManager.Shared.soundStatus.toggle()
            soundControlButoon.setTitle("音 有", for: .normal)
        }
    }
}

extension FlashSettingViewController: FlashValueSetDelegate {
    
    func numberOfQuestionValueDelivery(numberOfQuestion: Int) {
        FlashAnzanManager.Shared.numberOfQuestion = numberOfQuestion
    }
    
    func digitValueDelivery(digit: Int) {
        FlashAnzanManager.Shared.digit = digit
    }
    
    func intervalValueDelivery(interval: Double) {
        FlashAnzanManager.Shared.interval = Double(interval) / 1000
    }
    
    func numberOfQuestionCheckAlert() {
        if FlashAnzanManager.Shared.numberOfQuestion == 0 {
            alert(alertTitle: "入力エラー", alertMessage: "問題数を設定してください")
        } else if FlashAnzanManager.Shared.numberOfQuestion <= 1 || FlashAnzanManager.Shared.numberOfQuestion > 100  {
            alert(alertTitle: "条件エラー", alertMessage: "2~100問内で設定してください")
        }
    }
    
    func digitCheckAlert() {
        if FlashAnzanManager.Shared.digit == 0 {
            alert(alertTitle: "入力エラー", alertMessage: "桁数をを設定してください")
        }
    }
    
    func intervalCheckAlert() {
        if FlashAnzanManager.Shared.interval == 0 {
            alert(alertTitle: "入力エラー", alertMessage: "表示間隔を設定してください")
        } else if FlashAnzanManager.Shared.interval < 0.1 || FlashAnzanManager.Shared.interval > 3 {
            alert(alertTitle: "条件エラー", alertMessage: "100~3000ミリ秒内で設定してください")
        }
    }
}
