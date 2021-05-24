//
//  RequestInfo.swift
//
//  Created by 서상민 on 2021/03/22.
//

import Foundation
import Alamofire

/// API 요청 정보
public struct RequestInfo {
    
    /// 도메인
    public let baseURL: String? = {
        guard let url = Bundle.main.infoDictionary?["API_URL"] as? String else {
            ELog(error: NetworkError.unknownDomain)
            return nil
        }
        
        return url
    }()
    
    /// 헤더
    public var headers: HTTPHeaders
    
    /// 경로가 포함된 전체주소
    public var address: String {
        get {
            guard let url = self.baseURL else { return "" }
            
            var path = self.path
            if !path.hasPrefix("/") {
                path.insert("/", at: path.startIndex)
            }
                        
            return String(format: "%@%@", url, path)
        }
    }
    
    /// 경로
    public var path: String
    
    /// method 타입
    public var method: HTTPMethod
    
    /// 전달 데이터
    public var params: [String: Any]?
    
    /**
     초기화
     
     - Parameters:
        - headers: 헤더정보
        - path: 경로
        - method: method
     */
    public init(headers: [String: String] = [:], path: String = "", method: HTTPMethod = .get) {
        self.headers = HTTPHeaders(headers)
        self.path = path
        self.method = method
        self.params = nil
    }
    
    /**
     초기화
     
     - Parameters:
        - headers: 헤더정보
        - path: 경로
        - method: method
        - params: 전달 데이터
     */
    public init<T: Encodable>(headers: [String: String] = [:], path: String, method: HTTPMethod = .get, params: T?) {
        self.headers = HTTPHeaders(headers)
        self.path = path
        self.method = method
        
        if let params = params {
            do {
                let encode = try JSONEncoder().encode(params)
                self.params = try JSONSerialization.jsonObject(with: encode, options: .allowFragments) as? [String: Any]
            } catch let error {
                ELog(error: error)
                self.params = nil
            }
        } else {
            self.params = nil
        }
    }
}
