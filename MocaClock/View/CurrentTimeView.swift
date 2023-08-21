//
//  CurrentTime.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/04.
//

import SwiftUI

struct CurrentTimeView: View {
    @ObservedObject var Time: Scheduler
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text(Time.printCurrentTime(format: TimeFormat.time))
                    .font(.setMainClockFont())
                    .bold()
                Text([Time.printCurrentTime(format: TimeFormat.month), Time.printCurrentTime(format: TimeFormat.date), Time.printCurrentTime(format: TimeFormat.week)].joined(separator: " "))
                    .font(.setBodyFont())
                HStack {
                    Image("location_on")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16,height: 16)
                        .font(.setLocationFont())
                    Text("\(locationManager.currentPlacemark?.country ?? "reset the Location")")
                        .font(.setBodyFont())
                        .onAppear {
                            locationManager.requestLocation()
                        }
                    Text("\(locationManager.currentPlacemark?.locality ?? "")")
                        .font(.setBodyFont())
                }
            }
        }.padding(.trailing, 10)
    }
}


