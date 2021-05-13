//
//  Networking.swift
//
//  Created by 서상민 on 2021/03/22.
//

import Foundation
import Alamofire

public class Networking {
    
    private let queue = DispatchQueue(label: "SMlibrary.Network", qos: .utility, attributes: .concurrent)

    /**
     API 공통 요청
     
     - Parameter info: 요청 정보
     - Returns: __DataRequest__
     */
    private func request(info: RequestInfo) -> DataRequest {
        return AF
            .request(info.address, method: info.method, parameters: info.params, headers: info.headers, interceptor: Interceptor())
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
    }
    
    /**
     모든 요청 취소
     */
    public func allCancel() {
        AF.cancelAllRequests()
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
        self.request(info: info).responseDecodable(of: type, queue: self.queue, completionHandler: completionHandler)
    }
    
    /**
     API 응답 __Data__
     
     - Parameter info: 요청정보
     - Parameter completionHandler:
     - Parameter response: __AFDataResponse<Data>__
     */
    public func resData(info: RequestInfo, completionHandler: @escaping (_ response: AFDataResponse<Data>) -> Void) {
        self.request(info: info).responseData(queue: self.queue, completionHandler: completionHandler)
    }
}

