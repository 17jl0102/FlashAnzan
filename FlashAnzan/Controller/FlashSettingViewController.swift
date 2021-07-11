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
        //FlashSettingView.delegate = self
    }

    @IBAction func didTapTransitionQuestionView(_ sender: UIButton) {
        
        let questionViewController = storyboard?.instantiateViewController(withIdentifier: "QuestionViewController")
        present(questionViewController!, animated: true, completion: nil)
    }
}

extension FlashSettingViewController: FlashValueSetDelegate {
    
    func numberOfQuestionValueCheck(numberOfQuestion: Int) {
        setNumberOfQuestion = numberOfQuestion
    }
    
    func digitValueCheck(digit: Int) {
        setDigit = digit
    }
    
    func intervalValueCheck(interval: Double) {
        setInterval = interval
    }
    
//    func FlashValuse(numberOfQuestion: Int, digit: Int, displayInterval: Int) {
//    }

}
