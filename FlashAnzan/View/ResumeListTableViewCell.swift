//
//  resumeListTableViewCell.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/10/03.
//

import Foundation
import UIKit

protocol ResumeValueSetDelegate {
    func saveNumberOfQuestionValueDelibery(numberOfQuestion: Int)
    func saveDigitValueDelibery(digit: Int)
    func saveIntervalValueDelibery(interval: Double)
}

class ResumeListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberOfQuestionLabel: UILabel!
    @IBOutlet weak var digitLabel: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var anserJudgeLabel: UILabel!
    
    var index = 0
    var resumeManager: ResumeManager!
    var delegate: ResumeValueSetDelegate?
    
    
    func setup(resume: ResumeManager, indexPath: IndexPath) {
        self.index = indexPath.row
        self.resumeManager = resume
        numberOfQuestionLabel.text = String(resumeManager.savedNumberOfQuestion)
        digitLabel.text = String(resumeManager.savedNumberOfQuestion)
        intervalLabel.text = String(resumeManager.savedInterval)
        anserJudgeLabelSet(anserJudge: resumeManager.savedAnserJudge)
    }
    
    func anserJudgeLabelSet(anserJudge: Bool) {
        if anserJudge == true {
            anserJudgeLabel.text = "○"
        } else {
            anserJudgeLabel.text = "×"
        }
    }
    
    @IBAction func DidTapPlayResumeQuestionButton(_ sender: UIButton) {
        let resumes = resumeManager.resumes()
        delegate?.saveNumberOfQuestionValueDelibery(numberOfQuestion: resumes[index].savedNumberOfQuestion)
        delegate?.saveDigitValueDelibery(digit: resumes[index].savedDigit)
        delegate?.saveIntervalValueDelibery(interval: resumes[index].savedInterval)
        NotificationCenter.default.post(name: Notification.Name("resumePlay"), object: nil)
    }
}
