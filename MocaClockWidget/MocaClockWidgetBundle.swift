//
//  MocaClockWidgetBundle.swift
//  MocaClockWidget
//
//  Created by 최진용 on 2023/08/24.
//

import WidgetKit
import SwiftUI

@main
struct MocaClockWidgetBundle: WidgetBundle {
    var body: some Widget {
        MocaClockWidget()
        MocaClockWidgetLiveActivity()
    }
}
