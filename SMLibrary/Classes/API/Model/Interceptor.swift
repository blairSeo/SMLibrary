//
//  Interceptor.swift
//  SMLibrary
//
//  Created by 서상민 on 2021/05/11.
//

import Foundation
import Alamofire

class Interceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        #if DEBUG
        ILog(urlRequest)
        #endif
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse,
           (200..<300) ~= response.statusCode
        {
            completion(.retry)
        } else {
            ELog(error: error)
            completion(.doNotRetry)
        }
        
    }
}
