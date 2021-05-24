//
//  ProgressError.swift
//
//  Created by 서상민 on 2021/05/24.
//

import Foundation

public enum ProgressError: LocalizedError {
    case valueNill
    case outRangeProgress
    
    public var errorDescription: String? {
        get {
            switch self {
            case .valueNill:
                return "설정이 되어 있지 않습니다."
            case .outRangeProgress:
                return "입력 범위를 벗어났습니다."
            }
        }
    }
}
