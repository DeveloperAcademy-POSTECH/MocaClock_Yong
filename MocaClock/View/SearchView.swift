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
    
    var body: some View {
        VStack {
            SearchField().onTapGesture {
                self.isEditing = true
            }.padding()
            List {
                Text("1")
                Text("1")
                Text("1")
            }.onAppear {
                for timeZone in TimeZone.knownTimeZoneIdentifiers {
                    let time = timeZone.split(separator: "/")
                    if time.count >= 2 {
                        for idx in 1..<time.endIndex {
                            print(time[idx])
                        }
                    }
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
