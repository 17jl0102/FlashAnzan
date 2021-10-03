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
    var resumes: [ResumeManager] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resumeTableView.delegate = self
        resumeTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resumes =  [ResumeManager(savedNumberOfQuestion: 3, savedDigit: 1, savedInterval: 1.0, savedAnserJudge: true)] //ResumeManager.resumes()
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
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCell.EditingStyle.delete {
//            resumes.remove(at: indexPath.row)
//            ResumeManager.resumeUpdate(resumes: resumes)
//            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        return "削除"
//    }
}
