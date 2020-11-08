//
//  File.swift
//  
//
//  Created by Igor Kim on 08.11.20.
//

import Foundation
import IperfCLib

public enum IperfProtocol {
    case tcp
    case udp
    case sctp
    
    var iperfConfigValue: Int32 {
        switch self {
        case .tcp:
            return Ptcp
        case .udp:
            return Pudp
        case .sctp:
            return Psctp
        }
    }
}

public enum IperfRole: Int8 {
    case server = 115
    case client = 99
}

public enum IperfDirection: Int32 {
    case download = 1
    case upload = 0
}

public struct IperfConfiguration {
    var address: String? = "127.0.0.1"
    var numStreams = 2
    var role = IperfRole.client
    var reverse = IperfDirection.download
    var port = 5201
    var prot = IperfProtocol.tcp
    
    var rate: UInt64 = UInt64(1024*1024)
    
    var duration: TimeInterval?
    var timeout: TimeInterval?
    var tos: Int?
    
    var reporterInterval: TimeInterval?
    var statsInterval: TimeInterval?
}
