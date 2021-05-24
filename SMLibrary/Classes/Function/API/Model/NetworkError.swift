//
//  NetworkError.swift
//
//  Created by 서상민 on 2021/04/28.
//

import Foundation

/// 네트워크 에러
public enum NetworkError: LocalizedError {
    
    /// 도메인을 알 수 없음
    case unknownDomain
    
    /// 네트워크 에러의 설명
    public var errorDescription: String? {
        get {
            switch self {
            case .unknownDomain:
                return "Info.plist에 \"API_URL\" 이름의 Key를 생성하여 주소 값을 입력해 주세요!"
            }
        }
    }
}
