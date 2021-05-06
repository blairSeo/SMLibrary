//
//  MailResult.swift
//
//  Created by 서상민 on 2021/05/06.
//

import Foundation
import MessageUI

/// 메일 전송결과 정보
public enum MailResult: Int {
    /// 취소
    case cancelled = 0
    
    /// 저장
    case saved
    
    /// 성공
    case sent
    
    /// 실패
    case failed
    
    public init(value: MFMailComposeResult) {
        switch value {
        case .cancelled:
            self = .cancelled
        case .saved:
            self = .saved
        case .sent:
            self = .sent
        case .failed:
            self = .failed
        }
    }
}
