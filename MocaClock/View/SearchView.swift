//
//  SearchView.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/04.
//

import SwiftUI



struct SearchView: View {
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var cityNames: [[String]] = []
    @EnvironmentObject var schedular: Scheduler
    @Binding var isSearching: Bool
    
    var body: some View {
        ScrollView {
            LazyVStack {
                SearchField()
                    .padding(.bottom)
                HStack {
                    Text("Continent")
                        .font(.setBodyFont())
                    Spacer()
                    Text("City")
                        .font(.setBodyFont())
                }.padding(.horizontal)
                    .bold()
                Divider()
                ForEach(searchResult, id: \.self) { data in
                    TableViewCell(timeIdentifier: data[0], city: data[2], continent: data[1], isSearching: $isSearching)
                    Divider()
                }
            }
        }.padding()
            .onAppear {
                getAllCity()
            }
            .onDisappear {
                isSearching = false
            }
    }
    
    var searchResult: [[String]] {
        if searchText.isEmpty {
            return cityNames
        }
        else {
            return cityNames.filter{
                String($0[2].lowercased()).contains(searchText.lowercased())
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
            .opacity(0.7)
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
//MARK: - methods
    func getAllCity() {
        let timeZoneIdentifiers = TimeZone.knownTimeZoneIdentifiers
        for timeID in timeZoneIdentifiers {
            guard let county = timeID.split(separator: "/").first else { return }
            guard let city = timeID.split(separator: "/").last else { return }
            cityNames.append([timeID, String(county), String(city)])
        }
    }
}

