//
//  File.swift
//  
//
//  Created by Igor Kim on 08.11.20.
//

import Foundation

public struct IperfThroughput {
    public var rawValue: Double
    public var bps: Double {
        rawValue*8
    }
    
    public var Kbps: Double {
        return bps / 1024
    }
    public var Mbps: Double {
        return Kbps / 1024
    }
    public var Gbps: Double {
        return Mbps / 1024
    }
    
    public init(bytesPerSecond initValue: Double) {
        rawValue = initValue
    }
    
    public init(bytes initValue: UInt64, seconds: TimeInterval) {
        self.init(bytesPerSecond: Double(initValue) / seconds)
    }
}
