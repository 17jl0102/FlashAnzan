//
//  ResumeViewController.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/09/26.
//

import UIKit

class ResumeViewController: UIViewController {
    
    @IBOutlet weak var resumeTableView: UITableView!
    var resumeManager: ResumeManager!
    var resumes: [Resume] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resumeTableView.delegate = self
        resumeTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resumes = ResumeManager.resumes()
        resumeTableView.reloadData()
    }
}

extension ResumeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resumes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resumeTableView.dequeueReusableCell(withIdentifier: "resumeCell", for: indexPath) as! ResumeListTableViewCell
        cell.setup(resume: resumes[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            resumes.remove(at: indexPath.row)
            let resumeArchived = try! NSKeyedArchiver.archivedData(withRootObject: resumes, requiringSecureCoding: false)
            UserDefaults.standard.set(resumeArchived, forKey: "resume")
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "削除"
    }
}

extension ResumeViewController: ResumeValueSetDelegate {
    func resumeValueDelibery(resume: Resume) {
        FlashAnzanManager.flashAnZanShare.numberOfQuestion = resume.numberOfQuestion
        FlashAnzanManager.flashAnZanShare.digit = resume.digit
        FlashAnzanManager.flashAnZanShare.interval = resume.interval
    }
}
