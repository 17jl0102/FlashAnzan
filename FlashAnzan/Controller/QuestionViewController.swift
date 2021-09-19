//
//  QuestionViewController.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/06/27.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var flashNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FlashAnzanManager.share.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(playAgain), name: Notification.Name("playAgain"), object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            FlashAnzanManager.share.deliveryNumberOfQuestionValue()
            FlashAnzanManager.share.executeTimer()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        flashNumberLabel.text = ""
    }
    
    @objc func playAgain() {
        dismiss(animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            FlashAnzanManager.share.deliveryNumberOfQuestionValue()
            FlashAnzanManager.share.executeTimer()
        }
    }
}

extension QuestionViewController: flashQuestionDelegate {
    func anserInputViewControllerTransition() {
        let anserInputViewController = storyboard?.instantiateViewController(withIdentifier: "AnserInputViewController") as! AnserInputViewController
        present(anserInputViewController, animated: true, completion: nil)
    }
    
    func questionDisplay() {
        flashNumberLabel.text = FlashAnzanManager.share.digitNumberGenerator(digit: FlashAnzanManager.share.digit)
    }
    
    func blancDisplay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + FlashAnzanManager.share.interval/2) {
            self.flashNumberLabel.text = ""
        }
    }
}
