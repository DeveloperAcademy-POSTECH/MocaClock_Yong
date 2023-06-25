//
//  TimeFomatter.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/24.
//

import Foundation


enum FormatterType {
    case globalDate, globalMonth, globalWeek, globalTime, currentDate, currentMonth, currentWeek, currentTime
}


final class Formatter {
    
    var local = "Seoul"
    var timezone = "Asia"

    
    func getTimeFormat(by type: FormatterType) -> DateFormatter {
        switch type {
        case .currentTime:
            return currentTimeFormat
        case .currentDate:
            return currentDateFormat
        case .currentMonth:
            return currentMonthFormat
        case .currentWeek:
            return currentWeekFormat
        case .globalDate:
            return globalDateFormat
        case .globalMonth:
            return globalMonthFormat
        case .globalWeek:
            return globalWeekFormat
        case .globalTime:
            return globalTimeFormat
        }
    }
    
    var globalHourFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: local)
        formatter.timeZone = TimeZone(identifier: timezone)
        formatter.dateFormat = "HH"
        return formatter
    }
    
    var globalTimeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: local)
        formatter.timeZone = TimeZone(identifier: timezone)
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    var globalDateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: local)
        formatter.timeZone = TimeZone(identifier: timezone)
        formatter.dateFormat = "dd"
        return formatter
    }
    
    var globalMonthFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: local)
        formatter.timeZone = TimeZone(identifier: timezone)
        formatter.dateFormat = "MM"
        return formatter
    }
    
    var globalWeekFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: local)
        formatter.timeZone = TimeZone(identifier: timezone)
        formatter.dateFormat = "EEEE"
        return formatter
    }
    
    var currentHourFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }
    
    var currentTimeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    var currentDateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }
    
    var currentMonthFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter
    }
    
    var currentWeekFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }
    
}
