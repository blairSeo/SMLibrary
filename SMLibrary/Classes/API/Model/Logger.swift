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
    
    func requestDidCancel(_ request: Request) {
        ILog(request.description)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else { return }
        
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let json = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            let str = String(data: json, encoding: .utf8)
            
            ILog(str ?? "nil")
        } catch let error {
            let str = String(data: data, encoding: .utf8)
            ELog("Not JSON Format!\nResponse Data: \(str)\nDescription: \(error.localizedDescription)\n")
        }
    }
    
    func request(_ request: Request, didFailTask task: URLSessionTask, earlyWithError error: AFError) {
        ELog(error)
    }
}
