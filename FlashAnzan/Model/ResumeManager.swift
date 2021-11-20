//
//  SaveManager.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/10/02.
//

import Foundation

struct ResumeManager {
    private static let resumeDataKey = "resumeData"
    
    static func resumes() -> [Resume] {
        let resumeData = UserDefaults.standard.data(forKey: resumeDataKey)
        let resumeDatas = try? JSONDecoder().decode([Resume].self, from: resumeData ?? Data())
        return resumeDatas ?? []
    }
    
    static func addResumes(resume: Resume) {
        let archiveData = UserDefaults.standard.data(forKey: resumeDataKey)
        let archiveDatas = try? JSONDecoder().decode([Resume].self, from: archiveData ?? Data())
        var resumes = archiveDatas ?? []
        resumes.append(resume)
        let resumesArchive = try? JSONEncoder().encode(resumes)
        UserDefaults.standard.set(resumesArchive, forKey: resumeDataKey)
    }
    
    static func resumeUpdate(resumes: [Resume]) {
        let resumeArchived = try? JSONEncoder().encode(resumes)
        UserDefaults.standard.set(resumeArchived, forKey: resumeDataKey)
    }
}
