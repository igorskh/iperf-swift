//
//  File.swift
//  
//
//  Created by Igor Kim on 08.11.20.
//

import Foundation

enum IperfNotificationName: String {
    case status = "reporter"
}

extension Notification.Name {
    init(_ enumValue: IperfNotificationName) {
        self.init(enumValue.rawValue)
    }
}
