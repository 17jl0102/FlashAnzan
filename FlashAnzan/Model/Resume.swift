//
//  Resume.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/10/09.
//

import Foundation

class Resume: NSObject, NSCoding {
    
    let numberOfQuestion: Int
    let digit: Int
    let interval: Double
    let anserJudge: Bool
    
    init(numberOfQuestion: Int, digit: Int, interval: Double, anserJudge: Bool) {
        self.numberOfQuestion = numberOfQuestion
        self.digit = digit
        self.interval = interval
        self.anserJudge = anserJudge
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(numberOfQuestion, forKey: "numberOfQuestion")
        aCoder.encode(digit, forKey: "digit")
        aCoder.encode(interval, forKey: "interval")
        aCoder.encode(anserJudge, forKey: "anserJudge")
    }
    
    required init?(coder aDecoder: NSCoder) {
        numberOfQuestion = aDecoder.decodeInteger(forKey: "numberOfQuestion")
        digit = aDecoder.decodeInteger(forKey: "digit")
        interval = aDecoder.decodeDouble(forKey: "interval")
        anserJudge = aDecoder.decodeBool(forKey: "anserJudge")
    }
    
}
