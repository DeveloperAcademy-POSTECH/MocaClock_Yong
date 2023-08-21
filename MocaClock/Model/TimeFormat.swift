//
//  TimeFomatter.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/24.
//
import Foundation


enum TimeFormat: CaseIterable {
    case date, month, week, time, hour
}

extension TimeFormat {
    var form: String {
        switch self {
        case .date: return "dd"
        case .hour: return "HH"
        case .month: return "MMMM"
        case .time: return "HH:mm"
        case .week: return "EEEE"
        }
    }
}
