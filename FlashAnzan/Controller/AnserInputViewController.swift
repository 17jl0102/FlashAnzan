//
//  AnserInputViewController.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/07/18.
//

import UIKit

class AnserInputViewController: UIViewController {
    
    @IBOutlet weak var anserInputView: AnserInputView!
    
    @IBOutlet weak var anserInputLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        anserInputView.delegate = self
        buttonControl()
    }
    
    func buttonControl() {
        if FlashAnzanManager.share.anserValue == 0 {
            anserInputView.doubleZeroButton.isEnabled = false
            anserInputView.zeroButton.isEnabled = false
            anserInputView.clearButton.isEnabled = false
        } else {
            anserInputView.doubleZeroButton.isEnabled = true
            anserInputView.zeroButton.isEnabled = true
            anserInputView.clearButton.isEnabled = true
        }
    }
    
    func alert(alertTitle: String, alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    @IBAction func didTapAnserDoneButton(_ sender: UIButton) {
        if FlashAnzanManager.share.anserValue == 0 {
            alert(alertTitle: "回答が入力されていません", alertMessage: "回答を入力してください")
        } else if FlashAnzanManager.share.anserValue > 10000000 {
            FlashAnzanManager.share.anserValue = 0
            anserInputView.inputValue = ""
            anserInputLabel.text = ""
            alert(alertTitle: "入力エラー", alertMessage: "10,000,000以内で入力してください")
        } else {
            let resultViewController = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            present(resultViewController, animated: true, completion: nil)
        }
    }
}

extension AnserInputViewController: AnserInputValueDelegate {
    func anserInputValue(value: String) {
        FlashAnzanManager.share.anserValue = Int(value) ?? 0
        anserInputLabel.text = value
        buttonControl()
    }
}
