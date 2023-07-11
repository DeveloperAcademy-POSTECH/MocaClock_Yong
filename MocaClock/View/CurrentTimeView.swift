//
//  CurrentTime.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/04.
//

import SwiftUI

#warning("Todo - 모카랑 이야기해서 뷰 좀 바꾸자")

struct CurrentTimeView: View {
    @ObservedObject var Time: Scheduler
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text(Time.printCurrentTime(format: TimeFormat.time))
                    .font(.system(size: 75))
                    .bold()
//                    .padding(.bottom, 3)
                Text([Time.printCurrentTime(format: TimeFormat.month), Time.printCurrentTime(format: TimeFormat.date), Time.printCurrentTime(format: TimeFormat.week)].joined(separator: " "))
                HStack {
                    Image("location_on")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16,height: 16)
                        .font(.system(size:16, weight: .light))
                    Text("\(locationManager.currentPlacemark?.country ?? "")")
                        .font(.system(size: 16))
                        .onAppear {
                            locationManager.requestLocation()
                        }
                    Text("\(locationManager.currentPlacemark?.administrativeArea ?? "")")
                        .font(.system(size: 16))
                }
            }
        }.padding(.trailing, 10)
    }
}


