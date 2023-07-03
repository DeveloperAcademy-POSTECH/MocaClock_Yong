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

#warning("해야할일")
#warning("1. 현재 위치 받아오기")
#warning("2. 설정된 국가의 날짜, 요일, 그리고 위치 잡아오기")
#warning("3. 설정된 국가의 시간차에 따라서 line 높이 다르게 하기")
#warning("4. 시간차에 따라서 배경색 다르게 변경되도록 설정하기")
//MARK: -국가검색은 따로 sheet로 빼둿음, 해당 뷰에서 textfiled를 이용해서 검색하고 하위 테이블뷰 리로딩
//MARK: -timezone을 이용해서 다른나라의 시간을 가져올수 있을듯




struct ContentView: View {
    @State private var searchInput = ""
    @State private var isSearching = false
    @StateObject var Time = Scheduler()
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            BackGround()
            HStack {
                VStack(alignment: .leading) {
                    CurrentTimeView(Time: Time).environmentObject(locationManager)
                    Spacer()
                    TimeGapBar(timeGap: Time.timeGap)
                    GlobalTimeView(Time: Time)
                    ChangeLocationButton().sheet(isPresented: $isSearching) {
                        SearchView().presentationDragIndicator(.visible)
                    }
                }.padding()
                Spacer()
            }.foregroundColor(.white)
            .padding(.leading, 10)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                Time.date = Date()
                Time.timezone = Time.currentSelectedGlobalTime
                Time.timeGap = Time.getTimeGap(by: Time.timezone)
            }
        }
    }
    
    //이런경우는 어떻게 분기를 나누느게 좋을까요?
    func TimeGapBar(timeGap: Int) -> some View {
        HStack(alignment: .bottom) {
            if timeGap > 0 {
                Rectangle().frame(width: 2)
                    .foregroundColor(.clear)
                    .background(LinearGradient(colors: [Color.clear, Color.white], startPoint: .top, endPoint: .bottom))
            }
            else if timeGap == 0 {
                Rectangle().frame(width: 2)
                    .foregroundColor(.clear)
                    .background(LinearGradient(colors: [Color.clear, Color.white], startPoint: .top, endPoint: .bottom))
            }
            else {
                Rectangle().frame(width: 2)
                    .foregroundColor(.clear)
                    .background(LinearGradient(colors: [Color.white, Color.clear], startPoint: .top, endPoint: .bottom))
            }
            Text("\(timeGap) hour").padding(.leading)

        }.padding(.leading)
    }
    
    func BackGround() -> some View {
        VStack(spacing: 0){
            Color(uiColor: Color.darkBlue)
            LinearGradient(colors: [Color(uiColor: Color.darkBlue), Color(uiColor: Color.burgundy)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
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
