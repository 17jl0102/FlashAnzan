//
//  Resume.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/10/09.
//

import Foundation

struct Resume: Codable {
    let numberOfQuestion: Int
    let digit: Int
    let interval: Double
    let anserJudge: Bool
}
