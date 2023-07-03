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
            VStack(alignment: .leading) {
                Text(Time.print(by: .currentTime))
                    .font(.system(size: 60))
                    .bold()
                Text([Time.print(by: .currentMonth), Time.print(by: .currentDate), Time.print(by: .currentWeek)].joined(separator: " "))
            }
            Spacer()
            HStack {
                Image("location_on")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .bold()
                Text("\(locationManager.latitude), \(locationManager.longitude),\(locationManager.placeName)")
                    .font(.system(size: 20))
                    .bold()
                    .task {
                        await locationManager.forwardGeocoding(address: "Deagu")
                        await locationManager.reverseGeocoding(latitude: locationManager.latitude, longitude: locationManager.longitude)
                    }
            }.offset(y: 40)
        }
    }
}

