//
//  Scheduler.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/24.
//

import Foundation

final class Scheduler: ObservableObject {
    @Published var date = Date()
    
    let formatter = Formatter()

// globalTime과 currentTime의 차이를 가져오는 getter함수를 만들예정.
//    func getTimeGap() -> Int {
//        Int(formatter.globalHourFormat.string(from: date))
//    }
    
    func print(by type: FormatterType) -> String{
        switch type {
        case .globalDate: return "\(formatter.globalDateFormat.string(from: date)) 일"
        case .globalMonth:
            return "\(formatter.globalMonthFormat.string(from: date)) 월"
        case .globalWeek:
            return "\(formatter.globalWeekFormat.string(from: date))"
        case .globalTime:
            return formatter.globalTimeFormat.string(from: date)
        case .currentDate:
            return "\(formatter.currentDateFormat.string(from: date)) 일"
        case .currentMonth:
            return "\(formatter.currentMonthFormat.string(from: date)) 월"
        case .currentWeek:
            return "\(formatter.currentWeekFormat.string(from: date))"
        case .currentTime:
            return formatter.currentTimeFormat.string(from: date)
        }
    }
}
