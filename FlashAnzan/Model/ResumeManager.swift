//
//  SaveManager.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/10/02.
//

import Foundation

struct ResumeManager {
    
    static func resumes() -> [Resume] {
        let resumeData = UserDefaults.standard.data(forKey: "resume")
        return (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(resumeData ?? Data()) as? [Resume] ?? []) ?? []
    }
    
    static func addResumes(resume: Resume) {
        let resumeData = UserDefaults.standard.data(forKey: "resume")
        let unArchivedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(resumeData ?? Data()) as? [Resume] ?? []
        var resumes = unArchivedData ?? []
        resumes.append(resume)
        
        let resumesArchived = try! NSKeyedArchiver.archivedData(withRootObject: resumes, requiringSecureCoding: false)
        UserDefaults.standard.set(resumesArchived, forKey: "resume")
        UserDefaults.standard.synchronize()
    }
    
    static func resumeUpdate(resumes: [Resume]) {
        let resumeArchived = try! NSKeyedArchiver.archivedData(withRootObject: resumes, requiringSecureCoding: false)
        UserDefaults.standard.set(resumeArchived, forKey: "resume")
    }
}


