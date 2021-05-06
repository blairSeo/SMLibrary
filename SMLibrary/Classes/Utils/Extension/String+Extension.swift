//
//  String+Extension.swift
//
//  Created by 서상민 on 2021/05/03.
//

import Foundation

extension String {
    
    /// 문자열의 날짜를 Date형으로 변환
    ///
    /// - Parameter str: 문자열 날짜
    /// - Parameter format: 문자열 날짜의 format
    /// - returns: Date형의 날짜
    public func convertDate(format: String = "yyyy-MM-dd") -> Date? {
        let dFormatter = DateFormatter()
        
        dFormatter.dateFormat = format

        return dFormatter.date(from: self)
    }
}
