//
//  TableViewCell.swift
//  MocaClock
//
//  Created by 최진용 on 2023/08/20.
//

import SwiftUI


struct TableViewCell: View {
    var timeIdentifier: String = ""
    var city: String = ""
    var continent: String = ""
    @EnvironmentObject var schedular: Scheduler
    @Binding var isSearching: Bool

    
    var body: some View {
        Button {
            schedular.timezone = timeIdentifier
            schedular.currentSelectedGlobalTime = timeIdentifier
            schedular.timeGap = schedular.getTimeGap(by: schedular.timezone)
            isSearching = false
        } label: {
            HStack {
                Text(continent)
                    .font(.setBodyFont())
                Spacer()
                Text(city)
                    .font(.setBodyFont())
            }.padding(.horizontal)
        }
    }
}
