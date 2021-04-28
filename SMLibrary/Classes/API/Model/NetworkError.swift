//
//  NetworkError.swift
//
//  Created by 서상민 on 2021/04/28.
//

import Foundation

public enum NetworkError: Error {
    case unknownDomain
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        get {
            switch self {
            case .unknownDomain:
                return "Info.plist에 \"API_URL\" 이름의 Key를 생성하여 주소 값을 입력해 주세요!"
            }
        }
    }
}
