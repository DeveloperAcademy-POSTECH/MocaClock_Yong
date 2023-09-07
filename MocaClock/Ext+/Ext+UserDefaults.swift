//
//  Ext+UserDefaults.swift
//  MocaClock
//
//  Created by 최진용 on 2023/08/26.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.clockGroups"
        return UserDefaults(suiteName: appGroupId)!
    }
}
