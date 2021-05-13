//
//  Logger.swift
//  SMLibrary
//
//  Created by 서상민 on 2021/05/11.
//

import Foundation
import Alamofire

class Logger: EventMonitor {
    
    var queue: DispatchQueue = DispatchQueue(label: "SMlibrary.Network.Logger", qos: .background, attributes: .concurrent)
    
    func requestDidFinish(_ request: Request) {
        ILog(request.description)
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        guard let data = response.data else { return }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            ILog(json)
        }
    }
}
