//
//  SearchView.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/04.
//

import SwiftUI


#warning("Todo - 1. 서칭 기능추가")
#warning("Todo - 2. 각 섹션에 들어갈 timezone 세팅 어떻게 햐애할지 전혀모르겟음")

enum Continents: String, CaseIterable {
    case Africa, America, Antarctica, Asia, Atlantic, Australia, GMT, Europe, Indian, Pacific
}


struct SearchView: View {
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var sections = Continents.allCases
    @State private var timezone:[String:String] = [:]
    
    var body: some View {
        List {
            ForEach(sections, id: \.self) { section in
                Section {
                    Text("hi")
                } header: {
                    Text(section.rawValue)
                        .font(Font.title2)
                        .foregroundColor(Color.black)
                        .bold()
                }
            }
        }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                for time in TimeZone.knownTimeZoneIdentifiers {
                    let citys: [String] = time.components(separatedBy: "/")
                    switch citys.count {
                    case 1:
                        citys[0]
                        print(citys[0])
                    case 2:
                        print(time.components(separatedBy: "/")[1])
                    case 3:
                        print("\(time.components(separatedBy: "/")[1]),  \(time.components(separatedBy: "/")[2])")
                    default:
                        print("")
                    }
                }
            }
    }
    func SearchField() -> some View {
        TextField("Search here...", text: $searchText)
            .padding(10)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .foregroundColor(.black)
            .cornerRadius(12)
            .overlay {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)
                    if isEditing {
                        Button {
                            self.searchText = ""
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            }
    }
}

struct SearchView_Preview: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
