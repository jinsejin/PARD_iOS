//
//  ScheduleModel.swift
//  PARD
//
//  Created by 김하람 on 7/3/24.
//

import UIKit

struct ScheduleModel: Codable {
    let scheduleId: Int
    let title: String
    let date: String
    let content: String
    let part: String
    let contentsLocation: String
    let notice: Bool
    let remaingDay: Int
    let isPastEvent: Bool
}
