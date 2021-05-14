//
//  Logger.swift
//  SMLibrary
//
//  Created by 서상민 on 2021/05/11.
//

import Foundation
import Alamofire

class Logger: EventMonitor {
    
    var queue: DispatchQueue = DispatchQueue(label: "SMlibrary.Network.Logger", qos: .background)
    
    func requestDidFinish(_ request: Request) {
        ILog(request.description)
    }
    
    func requestDidResume(_ request: Request) {
        ILog(request.description)
    }
    
    func requestDidCancel(_ request: Request) {
        ILog(request.description)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else { return }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            ILog(json)
        }
    }
}
