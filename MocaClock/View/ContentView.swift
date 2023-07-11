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

#warning("Todo - 1. 설정된 국가의 시간차에 따라서 line 높이 다르게 하기")
#warning("Todo - 2. 시간차에 따라서 배경색 다르게 변경되도록 설정하기 ?? 여기 정책에 대해서 생각해보기")


struct ContentView: View {
    @State private var searchInput = ""
    @State private var isSearching = false
    @State private var isAnimation = false
    @StateObject var Time = Scheduler()
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            BackGround()
            HStack {
                VStack(alignment: .trailing) {
                    CurrentTimeView(Time: Time).environmentObject(locationManager)
                        .padding(.bottom)
//                    Spacer()
                    TimeGapBar(timeGap: Time.timeGap)
                    GlobalTimeView(Time: Time)
                    ChangeLocationButton()
                        .sheet(isPresented: $isSearching) {
                        SearchView().presentationDragIndicator(.visible)
                    }
                    Spacer()
                }.padding()
            }.foregroundColor(.white)
//            .padding(.trailing, 10)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                Time.date = Date()
            }
            Time.timezone = Time.currentSelectedGlobalTime
            Time.timeGap = Time.getTimeGap(by: Time.timezone)
            isAnimation.toggle()
        }
    }
    
    //이런경우는 어떻게 분기를 나누느게 좋을까요?
    // timeGap 에 따라서 현재 화면의 비율에서 % 별로 + - 로 이동해야하는데 애니메이션이 지금 이상하게 걸림.
    // 여기 지오메트릭 리더 이상하게 고ㅓㄹ림. 문제.
    func TimeGapBar(timeGap: Int) -> some View {
        
        HStack(alignment: .center) {
            Spacer()
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                Text("\(timeGap) hour")
                    .offset(x: width * (2.9/4), y: isAnimation ? (height * 0.5) : (height * 0.5))
                    .padding(.trailing)
                    .animation(.easeIn(duration: 2), value: isAnimation)
                    
                if timeGap > 0 {
                    Rectangle().frame(width: 2)
                        .foregroundColor(.clear)
                        .background(LinearGradient(colors: [Color.clear, Color.white], startPoint: .top, endPoint: .bottom))
                        .offset(x: width * (3.9/4))
                }
                else if timeGap == 0 {
                    Rectangle().frame(width: 2)
                        .foregroundColor(.clear)
                        .background(LinearGradient(colors: [Color.clear, Color.white], startPoint: .top, endPoint: .bottom))
                        .offset(x: width * (3.9/4))
                }
                else {
                    Rectangle().frame(width: 2)
                        .foregroundColor(.clear)
                        .background(LinearGradient(colors: [Color.white, Color.clear], startPoint: .top, endPoint: .bottom))
                        .offset(x: width * (3.9/4))
                }
            }
        }.padding(.trailing)
    }
    
    func BackGround() -> some View {
        VStack(spacing: 0){
            Color(uiColor: Color.darkBlue)
            LinearGradient(colors: [Color(uiColor: Color.darkBlue), Color(uiColor: Color.orange)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
        }.ignoresSafeArea()
    }
    
    func ChangeLocationButton() -> some View {
        Button {
            isSearching.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 56)
                .foregroundColor(Color.black.opacity(0.2))
                .overlay {
                    HStack {
                        Text("국가 변경하기")
                    }
                }
        }.padding(.vertical)
    }
}


struct RowView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
