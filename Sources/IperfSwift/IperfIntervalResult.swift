//
//  IperfIntervalResult.swift
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
    public var totalOutoforderPackets: Int32 = 0
    public var averageJitter: Double = 0.0
    public var averageRtt: Double = 0.0
    public var duration: TimeInterval = 0.0
    public var state: IperfState = .UNKNOWN
    public var debugDescription: String = ""
    
    public var startTime: TimeInterval = 0.0
    public var endTime: TimeInterval = 0.0
    
    public var throughput = IperfThroughput.init(bytesPerSecond: 0.0)
    public var hasError: Bool {
        error != .IENONE
    }
    public var error: IperfError = .UNKNOWN
    public var prot: IperfProtocol = .tcp
    
    public init(
        runnerState: IperfRunnerState = .unknown,
        debugDescription: String = "",
        state: IperfState = .UNKNOWN,
        error: IperfError = .UNKNOWN,
        prot: IperfProtocol = .tcp
    ) {
        self.runnerState = runnerState
        self.debugDescription = debugDescription
        self.state = state
        self.error = error
        self.prot = prot
    }
    
    mutating public func evaulate() {
        var sumJitter: Double = 0.0
        for s in streams {
            totalBytes += s.bytesTransferred
            if self.prot == .udp {
                totalPackets += s.intervalPacketCount
                totalLostPackets += s.intervalCntError
                totalOutoforderPackets += s.intervalOutoforderPackets
                sumJitter += s.jitter
            }
        }
        if let first = streams.first {
            startTime = first.startTime
            endTime = first.endTime
            duration = first.intervalDuration
            
            if self.prot == .udp {
                averageJitter = sumJitter / Double(streams.count)
            }
            throughput = IperfThroughput(bytes: totalBytes, seconds: first.intervalDuration)
        }
    }
}
