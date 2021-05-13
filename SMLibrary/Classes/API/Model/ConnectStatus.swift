//
//  ConnectStatus.swift
//  SMLibrary
//
//  Created by 서상민 on 2021/05/12.
//

import Foundation
import Alamofire

/**
 네트워크 연결 상태
 */
public enum ConnectStatus: CustomStringConvertible {  
    /**
     미 연결
     */
    case disconnect
    
    /**
     연결 (__ConnectType__)
     */
    case connect(ConnectType)
    
    /**
     연결된 네트워크 종류
     */
    public enum ConnectType {
        /**
         WIFI
         */
        case wifi
        
        /**
         Cellular
         */
        case cellular
        
        init(_ status: NetworkReachabilityManager.NetworkReachabilityStatus.ConnectionType) {
            switch status {
            case .cellular:
                self = .cellular
            case .ethernetOrWiFi:
                self = .wifi
            }
        }
    }
    
    /**
     연결 상태의 설명
     */
    public var description: String {
        get {
            switch self {
            case .connect(let type):
                return "Connection type: \(type)"
            case .disconnect:
                return "No Connection"
            }
        }
    }
}
