//
//  CircleProgress.swift
//
//  Created by 서상민 on 2021/05/24.
//

import Foundation

/// 원 Progress 출력
public class CircleProgress: UIView {
    
    /// 진행 상태값
    private var progress: CGFloat = 0.0
            
    /// 실 progress 정보
    private var progressInfo: ProgressInfo?
    
    /// 배경 progress 정보
    private var guidInfo: ProgressInfo?
    
    public override func draw(_ rect: CGRect) {
        guard let pInfo = self.progressInfo else {
            ELog(error: ProgressError.valueNill)
            return
        }
        
        let sAngle: CGFloat = .pi * 1.5
        let eAngle: CGFloat = sAngle + (.pi * 2)
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = (rect.size.width * 0.5) - (pInfo.linewidth / 2)
        
        if let gInfo = self.guidInfo {
            let bPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
            bPath.lineWidth = gInfo.linewidth
            bPath.lineCapStyle = gInfo.linestyle
            
            gInfo.linecolor.setStroke()
            bPath.stroke()
        }
        
        let fPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: sAngle, endAngle: (eAngle - sAngle) * self.progress + sAngle, clockwise: true)
        fPath.lineWidth = pInfo.linewidth
        fPath.lineCapStyle = pInfo.linestyle
        
        pInfo.linecolor.setStroke()
        fPath.stroke()
    }
    
    /**
     배경색상 설정
     
     - Parameter color: 배경색상
     */
    public func setBackground(color: UIColor) {
        self.backgroundColor = color
    }
    
    /**
     진행상태 설정
     
     - Parameter progress: 진행상태 (0 ~ 1)
     */
    public func setProgress(progress: CGFloat) {
        guard 0...1 ~= progress else {
            ELog(error: ProgressError.outRangeProgress)
            return
        }
        
        self.progress = progress
        super.setNeedsDisplay()
    }
    
    /**
     가이드 선 정보설정
     
     - Parameter info: 설정정보
     */
    public func setGuide(info: ProgressInfo) {
        self.guidInfo = info
    }
    
    /**
     progress 정보설정
     
     - Parameter info: 설정정보
     */
    public func setProgress(info: ProgressInfo) {
        self.progressInfo = info
    }
}
