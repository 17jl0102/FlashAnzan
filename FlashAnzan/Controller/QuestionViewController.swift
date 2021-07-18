//
//  QuestionViewController.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/06/27.
//

import UIKit


class QuestionViewController: UIViewController, UIApplicationDelegate {
    
    @IBOutlet weak var flashNumberLabel: UILabel!
    var numberOfQuestion = 0
    var digit = 0
    var interval:Double = 0
    var questionList:[Int] = []
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(flashQuesitonDisplay), userInfo: nil, repeats: true)
    }
    

    @objc func flashQuesitonDisplay() {
        if numberOfQuestion == 0 {
            timer?.invalidate()
            let anserInputViewController = storyboard?.instantiateViewController(withIdentifier: "AnserInputViewController") as! AnserInputViewController
            present(anserInputViewController, animated: true, completion: nil)
        } else {
            flashNumberLabel.text = digitNumberGenerator(digit: digit)
            questionList.append(Int(flashNumberLabel.text ?? "") ?? 0)
        }
        numberOfQuestion -= 1
    }

    func digitNumberGenerator(digit: Int) -> String {
        var questionNum = ""
        for _ in 1...digit {
            let randomInt = Int.random(in: 0...9)
            questionNum += String(randomInt)
        }
        return questionNum
    }
}
