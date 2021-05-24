//
//  ProgressError.swift
//
//  Created by 서상민 on 2021/05/24.
//

import Foundation

/// Progress 에러
public enum ProgressError: LocalizedError {
    /// 값이 nil일 경우
    case valueNill
    
    /// progress의 값이 범위를 벗어날 경우
    case outRangeProgress
    
    /// 설명
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
