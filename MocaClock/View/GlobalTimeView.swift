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
        VStack {
            Text(Time.print(by: .globalTime))
                .font(.system(size: 60))
                .bold()
            Text([Time.print(by: .globalMonth), Time.print(by: .globalDate), Time.print(by: .globalWeek)].joined(separator: " "))
                .font(.system(size: 16))
            HStack {
                Image("location_on")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .bold()
                Text("현재 위치")
                    .font(.system(size: 20))
                    .bold()
            }
        }
    }
}
