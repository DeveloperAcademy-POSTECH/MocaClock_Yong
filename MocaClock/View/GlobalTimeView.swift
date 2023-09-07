//
//  GlobalTimeView.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/24.
//

import SwiftUI





struct GlobalTimeView: View {
    @ObservedObject var Time: Scheduler
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(Time.printGlobalTime(by: Time.timezone, format: TimeFormat.time))
                .font(.setMainClockFont())
                .bold()
            Text(Time.printGlobalTime(by: Time.timezone, format: .widgetDate))
                .font(.setBodyFont())
            HStack {
                Image("location_on")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16,height: 16)
                    .font(.setLocationFont())
                ForEach(Time.timezone.split(separator: "/"), id: \.self) {
                    Text($0)
                        .font(.setBodyFont())
                }
                .frame(height: 20)
            }
        }.padding(.trailing, 10)
    }
}
