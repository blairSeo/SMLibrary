//
//  Networking.swift
//
//  Created by 서상민 on 2021/03/22.
//

import Foundation
import Alamofire

public class Networking {
    
    public static let shared = Networking()
    private var session = Session()
    
    public func setSession(_ config: URLSessionConfiguration = .default) {
        let rootQueue = DispatchQueue(label: "SMlibrary.Network", qos: .utility)
        let monitor = Logger()
        
        self.session = Session(configuration: config, rootQueue: rootQueue, eventMonitors: [monitor])
    }
    
    /**
     API 공통 요청
     
     - Parameter info: 요청 정보
     - Returns: __DataRequest__
     */
    private func request(info: RequestInfo) -> DataRequest {
        return self.session
            .request(info.address, method: info.method, parameters: info.params, headers: info.headers, interceptor: Interceptor())
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
    }
    
    /**
     모든 요청 취소
     */
    public func allCancel() {
        self.session.cancelAllRequests()
    }
    
    /**
     API 응답 __Decodable__
     
     - Parameters:
        - type: __Decodable__
        - info: 요청 정보
     - Parameter completionHandler:
     - Parameter response: __AFDataResponse<T>__
     */
    public func resDecodable<T: Decodable>(of type: T.Type = T.self, info: RequestInfo, completionHandler: @escaping (_ response: AFDataResponse<T>) -> Void) {
        self.request(info: info).responseDecodable(of: type, completionHandler: completionHandler)
    }
    
    /**
     API 응답 __Data__
     
     - Parameter info: 요청정보
     - Parameter completionHandler:
     - Parameter response: __AFDataResponse<Data>__
     */
    public func resData(info: RequestInfo, completionHandler: @escaping (_ response: AFDataResponse<Data>) -> Void) {
        self.request(info: info).responseData(completionHandler: completionHandler)
    }
}

