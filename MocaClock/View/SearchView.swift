//
//  SearchView.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/04.
//

import SwiftUI

//America, Africa, Antartica, Asia, Australia, Europe, Indian, Pacific


struct SearchView: View {
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var continents = Set<String>()
    @State private var countries: [[String]] = []
    @State private var America: [String] = []
    
    
    var body: some View {
        VStack {
            SearchField().onTapGesture {
                self.isEditing = true
            }.padding()
            List {
                Text("hi")
            }.onAppear {
                //                for timeZone in TimeZone.knownTimeZoneIdentifiers {
                //                    print(timeZone)
                //                    print(timeZone.split(separator: "/"))
                //                }
                ForEach(TimeZone.knownTimeZoneIdentifiers, id: \.self) {
                    if let continent = $0.components(separatedBy: "/").first {
                        
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

struct SearchView_Preview: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
