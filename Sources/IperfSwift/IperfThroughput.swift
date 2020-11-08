//
//  File.swift
//  
//
//  Created by Igor Kim on 08.11.20.
//

import Foundation

public struct IperfThroughput {
    var rawValue: Double
    var bps: Double {
        rawValue*8
    }
    
    var Kbps: Double {
        return bps / 1024
    }
    var Mbps: Double {
        return Kbps / 1024
    }
    var Gbps: Double {
        return Mbps / 1024
    }
    
    init(bytesPerSecond initValue: Double) {
        rawValue = initValue
    }
    
    init(bytes initValue: UInt64, seconds: TimeInterval) {
        self.init(bytesPerSecond: Double(initValue) / seconds)
    }
}
