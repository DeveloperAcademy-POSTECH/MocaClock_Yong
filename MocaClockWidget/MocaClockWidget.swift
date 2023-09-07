//
//  MocaClockWidget.swift
//  MocaClockWidget
//
//  Created by 최진용 on 2023/08/24.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {

    
    func placeholder(in context: Context) -> SimpleEntry {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let weekFormatter = DateFormatter()
        weekFormatter.dateFormat = "MMMM dd EEEE"
        let currentTimezone = "Asia Seoul"
        let currentTimeGap = 0
        return SimpleEntry(date: Date(), time: dateFormatter.string(from: Date()), week: weekFormatter.string(from: Date()), timezones: currentTimezone, timeGap: currentTimeGap)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let weekFormatter = DateFormatter()
        weekFormatter.dateFormat = "MMMM dd EEEE"
        let currentTimezone = "Asia Seoul"
        let currentTimeGap = 0
        let entry = SimpleEntry(date: Date(), time: dateFormatter.string(from: Date()), week: weekFormatter.string(from: Date()), timezones: currentTimezone, timeGap: currentTimeGap)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        
        let timezone = UserDefaults.shared.string(forKey: UserDefaultsKey.timezone.rawValue) ?? TimeZone.current.identifier
        let timegap = UserDefaults.shared.integer(forKey: UserDefaultsKey.timegap.rawValue)
        
        var entries = [SimpleEntry]()
        let currentDate = Date()
        let midnight = Calendar.current.startOfDay(for: currentDate)
        let nextMidnight = Calendar.current.date(byAdding: .day, value: 1, to: midnight)!
        let timezoneString = timezone.split(separator: "/").compactMap{ String($0) }.joined(separator: " ")
        
        for offset in 0 ..< 60 * 24 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: offset, to: midnight)!
            
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(identifier: timezone)
            formatter.locale = Locale(identifier: "en_US")
            formatter.dateFormat = "HH:mm"
            
            let weekFormatter = DateFormatter()
            weekFormatter.timeZone = TimeZone(identifier: timezone)
            weekFormatter.locale = Locale(identifier: "en_US")
            weekFormatter.dateFormat = "MMMM dd EEEE"
            
            let backgroundColorFormatter = DateFormatter()
            backgroundColorFormatter.timeZone = TimeZone(identifier: timezone)
            backgroundColorFormatter.dateFormat = "HH"
            
            guard let backgroundDecider = Int(backgroundColorFormatter.string(from: entryDate)) else { return }
            
            entries.append(SimpleEntry(date: entryDate, time: formatter.string(from: entryDate), week: weekFormatter.string(from: entryDate), timezones: timezoneString, timeGap: timegap, background: backgroundDecider))
        }

        let timeline = Timeline(entries: entries, policy: .after(nextMidnight))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date = Date()
    var time: String = ""
    var week: String = ""
    var timezones: String = ""
    var timeGap = 0
    var background = 0
}

struct MocaClockWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
            background
            view
        }
    }

//MARK: - UI
    var background: some View {
        VStack(spacing: 0) {
            switch entry.background {
            case 22..<24:
                BackGroundColors.nightTop
                BackGroundColors.night
            case 0..<2:
                BackGroundColors.nightTop
                BackGroundColors.lateNight
            case 2..<4:
                BackGroundColors.nightTop
                BackGroundColors.dawn
            case 4..<6:
                BackGroundColors.earlyDawnTop
                BackGroundColors.earlyDawn
            case 6..<8:
                BackGroundColors.night
                BackGroundColors.earlyMorining
            case 8..<10:
                BackGroundColors.moringTop
                BackGroundColors.moring
            case 10..<12:
                BackGroundColors.lunchTop
                BackGroundColors.latelunch
            case 12..<14:
                BackGroundColors.lateLunchTop
                BackGroundColors.latelunch
            case 14..<16:
                BackGroundColors.lunchTop
                BackGroundColors.earlyNightfall
            case 16..<18:
                BackGroundColors.night
                BackGroundColors.otherNightfall
            case 18..<20:
                BackGroundColors.dinnerTop
                BackGroundColors.lateDinnerBottom
            case 20..<22:
                BackGroundColors.nightTop
                BackGroundColors.nightBottom
            default:
                BackGroundColors.dinnerTop
                BackGroundColors.lateDinnerBottom
            }
        }
    }
    
    var view: some View {
        VStack(alignment: .center) {
            Text(entry.time)
                .foregroundColor(.defaultWhite)
                .font(.setWidgetClockFont())
                .padding(.bottom, 2)
            HStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 3) {
                    Text(entry.week)
                        .foregroundColor(.defaultWhite)
                        .font(.setWidgetDefaultFont())
                    HStack(spacing: 3) {
                        Image("location_on")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 9,height: 9)
                            .font(.setLocationFont())
                            .foregroundColor(.defaultWhite)
                        Text(entry.timezones)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.defaultWhite)
                            .font(.setWidgetDefaultFont())
                    }
                    Text("\(entry.timeGap) hours")
                        .foregroundColor(.defaultWhite)
                        .font(.setWidgetDefaultFont())
                }
            }.padding(.trailing)
        }
    }
}


struct MocaClockWidget: Widget {
    let kind: String = "MocaClockWidget.test.test"
    
    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MocaClockWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("MocaClock")
        .description("세계 시간과 시차를 알려주는 앱")
        .supportedFamilies([.systemSmall])
    }
}
