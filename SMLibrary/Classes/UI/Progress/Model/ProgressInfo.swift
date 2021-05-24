//
//  ProgressInfo.swift
//  SMLibrary
//
//  Created by 서상민 on 2021/05/24.
//

import Foundation

/// 원 Progress의 스타일 정보
public struct ProgressInfo {
    
    /// 색상
    public var linecolor: UIColor
    
    /// 선 끝점 스타일 [CGLineCap](https://developer.apple.com/documentation/coregraphics/cglinecap)
    public var linestyle: CGLineCap
    
    /// 선 굵기
    public var linewidth: CGFloat
    
    /**
     초기화
     
     - Parameters:
        - color: 색상
        - style: 선 끝점 스타일
        - width: 선 굵이
     */
    public init(color: UIColor = .clear, style: CGLineCap = .round, width: CGFloat = 1) {
        self.linecolor = color
        self.linestyle = style
        self.linewidth = width
    }
}
