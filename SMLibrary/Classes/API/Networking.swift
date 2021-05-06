//
//  Networking.swift
//
//  Created by 서상민 on 2021/03/22.
//

import Foundation
import Alamofire

public class Networking {
    
    /// API 요청 (Decodable)
    ///
    /// - Parameters:
    ///   - type: Decodable 객체 타입
    ///   - info: 요청 정보
    ///   - completion: 응답결과 반환
    ///     - Decodable 객체
    ///     - Error
    public static func request<T: Decodable>(of type: T.Type, info: RequestInfo, completion: @escaping (Result<T, Error>) -> Void) {
        AF
            .request(info.address,
                   method: info.method,
                   parameters: info.params,
                   headers: info.headers)
            .responseDecodable(of: type) { (response) in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    ELog(error)
                    completion(.failure(error))
                }
            }
    }
    
    /// API 요청 (Data)
    ///
    /// - Parameters:
    ///   - info: 요청 정보
    ///   - completion: 응답결과 반환
    ///     - Data 객체
    ///     - Error
    public static func request(info: RequestInfo, completion: @escaping (Result<Data, Error>) -> Void) {
        AF
            .request(info.address,
                     method: info.method,
                     parameters: info.params,
                     headers: info.headers)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    ELog(error)
                    completion(.failure(error))
                }
            }
    }
}

