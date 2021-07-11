//
//  QuestionViewController.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/06/27.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var flashNumberLabel: UILabel!
    var numberOfQuestion = 3
    var digit = 0
    var interval:Double = 1.0
    var randomInt = Int.random(in: 1...5)
    var questionList:[Int] = []
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(flashQuesitonDisplay), userInfo: nil, repeats: true)
    }
    

    @objc func flashQuesitonDisplay() {
        if numberOfQuestion == 0 {
            timer?.invalidate()
        } else {
            let quesitonInt:Int = randomInt
            flashNumberLabel.text = "\(quesitonInt)"
            questionList.append(Int(flashNumberLabel.text ?? "") ?? 0)
        }
        numberOfQuestion -= 1
    }

}
