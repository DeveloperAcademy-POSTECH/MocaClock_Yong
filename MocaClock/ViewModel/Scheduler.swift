//
//  Scheduler.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/24.
//

import Foundation
import SwiftUI

final class Scheduler: ObservableObject {
    @Published var date = Date()
    @Published var timeGap = 0
    @Published var timezone = "Asia/Tokyo"
    @AppStorage("currentSelectedGlobalTime") var currentSelectedGlobalTime = "Asia/Tokyo"
    
    
    func printGlobalTime(by timezone: String, format: TimeFormat) -> String {
        let timezone = TimeZone(identifier: timezone)
        let formatter = DateFormatter()
        formatter.timeZone = timezone
        formatter.dateFormat = format.form
        switch format.self {
        case .date: return "\(formatter.string(from: date))일"
        case .hour: return formatter.string(from: date)
        case .month: return "\(formatter.string(from: date))월"
        case .time: return formatter.string(from: date)
        case .week: return formatter.string(from: date)
        }
    }
    
    func printCurrentTime(format: TimeFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.form
        switch format.self {
        case .date: return "\(formatter.string(from: date))일"
        case .hour: return formatter.string(from: date)
        case .month: return "\(formatter.string(from: date))월"
        case .time: return formatter.string(from: date)
        case .week: return formatter.string(from: date)
        }
    }
    
    func getTimeGap(by timezone: String) -> Int {
        let current = printCurrentTime(format: .hour)
        let global = printGlobalTime(by: timezone, format: .hour)
        if let currentTime = Int(current), let globalTime = Int(global) {
            return currentTime - globalTime
        }
        else {
            return 0
        }
    }
}
