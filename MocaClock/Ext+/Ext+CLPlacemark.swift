//
//  Ext+CLPlacemark.swift
//  MocaClock
//
//  Created by 최진용 on 2023/06/05.
//

import Foundation
import CoreLocation

extension CLPlacemark {

    var address: String? {
        if let name = name {
            var result = name
            if let city = locality {
                result += ", \(city)"
            }
            if let country = country {
                result += ", \(country)"
            }
            return result
        }
        return nil
    }

}
