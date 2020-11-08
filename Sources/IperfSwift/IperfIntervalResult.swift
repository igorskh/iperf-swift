//
//  File.swift
//  
//
//  Created by Igor Kim on 08.11.20.
//

import Foundation

struct IperfIntervalResult: Identifiable {
    var id = UUID()
    var runnerState: IperfRunnerState = .unknown
    
    var streams: [IperfStreamIntervalResult] = []
    
    var totalBytes: UInt64 = 0
    var totalPackets: Int32 = 0
    var totalLostPackets: Int32 = 0
    var averageJitter: Double = 0.0
    var duration: TimeInterval = 0.0
    var state: IperfState = .UNKNOWN
    var debugDescription: String = ""
    
    var throughput = IperfThroughput.init(bytesPerSecond: 0.0)
    var hasError: Bool {
        state.rawValue < 0 || error != .IENONE
    }
    var error: IperfError = .IENONE
    
    mutating func evaulate() {
//        var sum_jitter: Double = 0.0
        for s in streams {
            totalBytes += s.bytesTransferred
//            totalPackets += s.intervalPacketCount
//            totalLostPackets += s.intervalCntError
//            sum_jitter += s.jitter
        }
        if let first = streams.first {
            duration = first.intervalDuration
//            averageJitter = sum_jitter / Double(streams.count)
            throughput = IperfThroughput(bytes: totalBytes, seconds: first.intervalDuration)
        }
    }
}
