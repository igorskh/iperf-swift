//
//  File.swift
//  
//
//  Created by Igor Kim on 08.11.20.
//

import Foundation
import IperfCLib

struct IperfStreamIntervalResult {
//#if (defined(linux) || defined(__FreeBSD__) || defined(__NetBSD__)) && \
//    defined(TCP_INFO)
//    struct tcp_info tcpInfo; /* getsockopt(TCP_INFO) for Linux, {Free,Net}BSD */
//    TAILQ_ENTRY(iperf_interval_results) irlistentries;
//    void     *custom_data;
    var bytesTransferred: UInt64 = 0
    var intervalDuration: Double = 0
    var intervalPacketCount: Int32 = 0
    var intervalOutoforderPackets: Int32 = 0
    var intervalCntError: Int32 = 0
    
    var packetCount: Int32 = 0
    var jitter: Double = 0
    var outoforderPackets: Int32 = 0
    var cnt_error: Int32 = 0
    var omitted: Int32 = 0
    
    var intervalRetrans: Int32 = 0
    var intervalSacks: Int32 = 0
    var sndCwnd: Int32 = 0
    var rtt: Int32 = 0
    var rttvar: Int32 = 0
    var pmtu: Int32 = 0
    
    var intervalTimeDiff = TimeInterval(0.0)
    
    init(_ results: iperf_interval_results) {
        var diff = iperf_time()
        var time1Pointer: UnsafeMutablePointer<iperf_time>?
        var time2Pointer: UnsafeMutablePointer<iperf_time>?
        
        var timeConv1 = results.interval_end_time
        withUnsafeMutablePointer(to: &timeConv1) { pointer in
            time1Pointer = pointer
        }
        var timeConv2 = results.interval_start_time
        withUnsafeMutablePointer(to: &timeConv2) { pointer in
            time2Pointer = pointer
        }
        
        iperf_time_diff(time1Pointer, time2Pointer, &diff)
        intervalTimeDiff = Double(diff.secs) + Double(diff.usecs)*1e-6
        
        bytesTransferred = results.bytes_transferred
        intervalDuration = Double(results.interval_duration)
        
        // MARK: UDP only results
        intervalPacketCount = results.interval_packet_count
        intervalOutoforderPackets = results.interval_outoforder_packets
        intervalCntError = results.interval_cnt_error
        packetCount = results.packet_count
        jitter = results.jitter
        outoforderPackets = results.outoforder_packets
        cnt_error = results.cnt_error
        
        omitted = results.omitted
        
        intervalRetrans = results.interval_retrans
        intervalSacks = results.interval_sacks
        sndCwnd = results.snd_cwnd
        rtt = results.rtt
        rttvar = results.rttvar
        pmtu = results.pmtu
    }
}
