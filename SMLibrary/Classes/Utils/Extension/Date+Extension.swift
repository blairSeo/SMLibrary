//
//  Date+Extension.swift
//
//  Created by 서상민 on 2021/05/03.
//

import Foundation

extension Date {
    
    /// 문자열의 Date형를 날짜으로 변환
    ///
    /// - Parameter date: 날짜
    /// - Parameter format: 출력 포맷
    /// - returns: 문자열의 날짜
    public func convertString(format: String = "yyyy-MM-dd") -> String {
        let dFormatter = DateFormatter()
        
        dFormatter.dateFormat = format
        
        return dFormatter.string(from: self)
    }

    /// 현재 성인여부 조회
    /// 
    /// - Parameter input: 입력 날짜
    /// - Returns: 성인 여부
    public func chkAdultAge(date input: Date, completion: @escaping (_ isAdult: Bool) -> Void) {
        guard let year = Calendar.current.dateComponents([.year], from: input, to: Date()).year else { return }
        completion(year > 19)
    }

    /// 현재날짜를 기준으로 24시간이 넘었는지 조회
    ///
    /// - Note: DEBUG = 30min, RELEASE = 24hour
    /// - Parameter target: 조회할 날짜
    /// - Returns: 24시간이 넘었는지 여부
    public func chk24Hour(date target: Date) -> Bool {
        let components = Calendar.current.dateComponents([.hour, .minute], from: target, to: Date())

        #if DEBUG
        return components.minute! < 30
        #else
        return components.hour! < 24
        #endif
    }
}
