//
//  Log.swift
//
//  Created by 서상민 on 2021/03/22.
//

import Foundation

/**
 파일 이름
 
 - Parameter path: 파일 경로
 */
private func filename(_ path: String) -> String {
    guard let filename = path.split(separator: "/").last else { return path }
    return String(filename)
}

/**
 에러 Log 출력
 
 - Parameters:
    - error: Error 객체
    - file: 파일 경로
    - function: 함수 이름
    - line: 줄 번호
 */
public func ELog(error: Error, file: String = #file, function: String = #function, line: Int = #line) {
    print("🤯\t[\(filename(file))]\t\(function)(\(line)): \(error.localizedDescription)\n")
}

/**
 에러 Log 출력
 
 - Parameters:
    - msg: Generics 객체
    - file: 파일 경로
    - function: 함수 이름
    - line: 줄 번호
 */
public func ELog<T>(_ msg: T, file: String = #file, function: String = #function, line: Int = #line) {
    print("🤯\t[\(filename(file))]\t\(function)(\(line)): \(msg)\n")
}

/**
 안내 Log 출력
 
 - Parameters:
    - msg: Generics 객체
    - file: 파일 경로
    - function: 함수 이름
    - line: 줄 번호
 */
public func ILog<T>(_ msg: T, file: String = #file, function: String = #function, line: Int = #line ) {
    print("📝\t[\(filename(file))]\t\(function)(\(line)): \(msg)\n")
}
