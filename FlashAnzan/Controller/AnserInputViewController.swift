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
    var anserValue = 0
    var quesitonList:[Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        anserInputView.delegate = self
        buttonControl()
    }
    
    func buttonControl() {
        if anserValue == 0 {
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
        if anserValue == 0 {
            alert(alertTitle: "回答が入力されていません", alertMessage: "回答を入力してください")
        } else {
            let resultViewController = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            resultViewController.anserValue = anserValue
            resultViewController.questionList = quesitonList
            resultViewController.quesitonResultInt = quesitonList.reduce(0){$0 + $1}
            present(resultViewController, animated: true, completion: nil)
        }
    }
    
}

extension AnserInputViewController: AnserInputValueDelegate {
    func anserInputValue(value: String) {
        anserValue = Int(value) ?? 0
        anserInputLabel.text = value
        buttonControl()
    }
}
