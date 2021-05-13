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
}
