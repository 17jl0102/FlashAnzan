//
//  SaveManager.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/10/02.
//

import Foundation
import UIKit

class ResumeManager: NSObject, NSCoding {
    
    let savedNumberOfQuestion: Int
    let savedDigit: Int
    let savedInterval: Double
    let savedAnserJudge: Bool
    
    init(savedNumberOfQuestion: Int, savedDigit: Int, savedInterval: Double, savedAnserJudge: Bool) {
        self.savedNumberOfQuestion = savedNumberOfQuestion
        self.savedDigit = savedDigit
        self.savedInterval = savedInterval
        self.savedAnserJudge = savedAnserJudge
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(savedNumberOfQuestion, forKey: "savedNumberOfQuestion")
        aCoder.encode(savedDigit, forKey: "savedDigit")
        aCoder.encode(savedInterval, forKey: "savedInterval")
        aCoder.encode(savedAnserJudge, forKey: "savedAnserJudge")
    }
    
    required init?(coder aDecoder: NSCoder) {
        savedNumberOfQuestion = aDecoder.decodeObject(forKey: "savedNumberOfQuestion") as! Int
        savedDigit = aDecoder.decodeInteger(forKey: "savedDigit")
        savedInterval = aDecoder.decodeDouble(forKey: "savedInterval")
        savedAnserJudge = aDecoder.decodeBool(forKey: "savedAnserJudge")
    }
    
        func resumes() -> [ResumeManager] {
            let resumeData = UserDefaults.standard.data(forKey: "resume")
            return (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(resumeData ?? Data()) as? [ResumeManager] ?? []) ?? []
        }
        
        func addResumes(resume: ResumeManager) {
            let resumeData = UserDefaults.standard.data(forKey: "resume")
            let unArchivedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(resumeData ?? Data()) as? [ResumeManager] ?? []
            var resumes = unArchivedData ?? []
            resumes.append(resume)
            resumeUpdate(resumes: resumes)
            UserDefaults.standard.synchronize()
        }
        
        func resumeUpdate(resumes: [ResumeManager]) {
            let tasksArchived = try! NSKeyedArchiver.archivedData(withRootObject: resumes, requiringSecureCoding: false)
            UserDefaults.standard.set(tasksArchived, forKey: "resume")
        }
}


