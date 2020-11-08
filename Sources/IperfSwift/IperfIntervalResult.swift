//
//  File.swift
//  
//
//  Created by Igor Kim on 08.11.20.
//

import Foundation

public struct IperfIntervalResult: Identifiable {
    public var id = UUID()
    public var runnerState: IperfRunnerState = .unknown
    
    public var streams: [IperfStreamIntervalResult] = []
    
    public var totalBytes: UInt64 = 0
    public var totalPackets: Int32 = 0
    public var totalLostPackets: Int32 = 0
    public var averageJitter: Double = 0.0
    public var duration: TimeInterval = 0.0
    public var state: IperfState = .UNKNOWN
    public var debugDescription: String = ""
    
    public var throughput = IperfThroughput.init(bytesPerSecond: 0.0)
    public var hasError: Bool {
        state.rawValue < 0 || error != .IENONE
    }
    public var error: IperfError = .IENONE
    
    mutating public func evaulate() {
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
