//
//  MocaClockApp.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/03.
//

import SwiftUI

@main
struct MocaClockApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
