//
//  Log.swift
//
//  Created by 서상민 on 2021/03/22.
//

import Foundation

private func filename(_ path: String) -> String {
    guard let filename = path.split(separator: "/").last else { return path }
    return String(filename)
}

public func ELog(error: Error, file: String = #file, function: String = #function, line: Int = #line) {
    print("🤬 [Error] \(filename(file))(\(line)):\n\(error.localizedDescription)\n")
}

public func ELog<T>(_ msg: T, file: String = #file, function: String = #function, line: Int = #line) {
    print("🤬 [Error] \(filename(file))(\(line)):\n\(msg)\n")
}

public func ILog<T>(_ msg: T, file: String = #file, function: String = #function, line: Int = #line ) {
    print("😀 [Info] \(filename(file))(\(line)):\n\(msg)\n")
}
