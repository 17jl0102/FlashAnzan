//
//  resumeListTableViewCell.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/10/03.
//

import Foundation
import UIKit

protocol ResumeListTableViewCellDelegate: AnyObject {
    func didTapResume(resume: Resume)
}

class ResumeListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberOfQuestionLabel: UILabel!
    @IBOutlet weak var digitLabel: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var anserJudgeLabel: UILabel!
    var index = 0
    var resume: Resume!
    weak var delegate: ResumeListTableViewCellDelegate?
    
    func setup(resume: Resume, indexPath: IndexPath) {
        self.index = indexPath.row
        self.resume = resume
        numberOfQuestionLabel.text = String(resume.numberOfQuestion)
        digitLabel.text = String(resume.digit)
        intervalLabel.text = String(resume.interval)
        anserJudgeLabelSet(anserJudge: resume.anserJudge)
    }
    
    func anserJudgeLabelSet(anserJudge: Bool) {
        if anserJudge == true {
            anserJudgeLabel.text = "○"
        } else {
            anserJudgeLabel.text = "×"
        }
    }
    
    @IBAction func didTapPlayResumeQuestionButton(_ sender: UIButton) {
        let resumes = ResumeManager.resumes()
        let resume = resumes[index]
        delegate?.didTapResume(resume: resume)
    }
}
