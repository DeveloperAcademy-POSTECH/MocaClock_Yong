//
//  ContentView.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/03.
//

import SwiftUI
import CoreData
import CoreLocation
import CoreLocationUI


struct ContentView: View {
    @State private var searchInput = ""
    @State private var isSearching = false
    @State private var isAnimation = false
    @State private var isShowText = false
    @StateObject var schedular = Scheduler()
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            BackGround()
            HStack {
                VStack(alignment: .trailing) {
                    CurrentTimeView(Time: schedular).environmentObject(locationManager)
                        .padding(.bottom)
                    ZStack {
                        TimeGapBar
                        TimePointer
                        .padding(.vertical)
                    }
                    GlobalTimeView(Time: schedular)
                    ChangeLocationButton()
                        .sheet(isPresented: $isSearching) {
                            SearchView(isSearching: $isSearching)
                                .environmentObject(schedular)
                                .presentationDragIndicator(.visible)
                                .presentationDetents([.height(UIScreen.deviceHeight * 0.87)])
                                .presentationBackground(.ultraThinMaterial)
                    }
                    Spacer()
                }.padding()
            }.foregroundColor(.white)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                schedular.date = Date()
            }
            schedular.timezone = schedular.currentSelectedGlobalTime
            schedular.timeGap = schedular.getTimeGap(by: schedular.timezone)
            isAnimation = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isShowText = true
            }

        }
        .onChange(of: isSearching) { _ in
            if isSearching {
                isAnimation = false
                isShowText = false
            }
            else {
                isAnimation = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isShowText = true
                }
            }
        }
    }
    
    var TimePointer: some View {
        GeometryReader { proxy in
            let height = proxy.size.height
            let width = proxy.size.width
            let arrowHeight = height * 0.44 + (height * Double(schedular.timeGap) / 40)
            Image("arrow")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.defaultWhite)
                .offset(x: width * 0.965,y: isAnimation ? arrowHeight : height * 0.44)
                .animation(.linear(duration: 0.8), value: isAnimation)
            Text("\(showTimeGapSign())\(schedular.timeGap) hours")
                .offset(x: width * 0.74,y: arrowHeight)
                .opacity(isShowText ? 1 : 0)
                .animation(.linear(duration: 1), value: isShowText)
                .font(.setBodyFont())
        }.padding()
    }
    

    var TimeGapBar: some View {
        HStack(alignment: .center) {
            Spacer()
                if schedular.timeGap > 0 {
                    Rectangle().frame(width: 2)
                        .foregroundColor(.clear)
                        .background(LinearGradient(colors: [Color.clear, Color.white], startPoint: .top, endPoint: .bottom))
                }
                else if schedular.timeGap == 0 {
                    Rectangle().frame(width: 2)
                        .foregroundColor(.clear)
                        .background(LinearGradient(colors: [Color.clear, Color.white], startPoint: .top, endPoint: .bottom))
                }
                else {
                    Rectangle().frame(width: 2)
                        .foregroundColor(.clear)
                        .background(LinearGradient(colors: [Color.white, Color.clear], startPoint: .top, endPoint: .bottom))
            }
        }.padding(.trailing)
    }
    
    func BackGround() -> some View {
        VStack(spacing: 0){
            switch Int(schedular.printGlobalTime(by: schedular.timezone, format: .hour))! {
            /*
             -
             BackGroundColors.earlyDawnTop
             BackGroundColors.earlyDawn
             -
             BackGroundColors.night
             BackGroundColors.earlyMorining
             -
             BackGroundColors.moringTop
             BackGroundColors.moring
             -
             BackGroundColors.lunchTop
             BackGroundColors.latelunch
             -
             BackGroundColors.lateLunchTop
             BackGroundColors.latelunch
             -
             BackGroundColors.lunchTop
             BackGroundColors.earlyNightfall
             -
             BackGroundColors.lunchTop
             BackGroundColors.otherNightfall
             -
             BackGroundColors.dinnerTop
             BackGroundColors.lateDinnerBottom
             -
             BackGroundColors.nightTop
             BackGroundColors.nightBottom
             */
                
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
        }.ignoresSafeArea()
    }

    
    func ChangeLocationButton() -> some View {
        Button {
            isSearching = true
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: UIScreen.deviceHeight * 0.068)
                .foregroundColor(Color.black.opacity(0.2))
                .overlay {
                    HStack {
                        Text("Change TimeZone")
                            .font(.setBodyFont())
                    }
                }
        }.padding(.vertical)
    }
    
    //MARK: - methods
    func showTimeGapSign() -> String {
        if schedular.timeGap.signum() == 1 {
            return "+"
        }
        else {
            return ""
        }
    }
}


struct RowView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
