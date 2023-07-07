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
        VStack(alignment: .leading) {
            Text(Time.printGlobalTime(by: Time.timezone, format: TimeFormat.time))
                .font(.system(size: 60))
                .bold()
                .padding(.bottom, 3)
            Text([Time.printGlobalTime(by: Time.timezone, format: TimeFormat.month), Time.printGlobalTime(by: Time.timezone, format: TimeFormat.date), Time.printGlobalTime(by: Time.timezone, format: TimeFormat.week)].joined(separator: " "))
                .font(.system(size: 16))
            HStack {
                Image("location_on")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .bold()
                ForEach(Time.timezone.split(separator: "/"), id: \.self) {
                    Text($0)
                }
                .frame(height: 20)
                .bold()
            }
        }
    }
}
