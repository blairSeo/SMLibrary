//
//  Mail.swift
//
//  Created by 서상민 on 2021/05/05.
//

import Foundation
import MessageUI

public protocol MailDelegate: NSObjectProtocol {
    
    /**
     메일 전송 결과
     
     - Parameters:
        - result: 전송결과 정보
        - error: 에러 정보
     */
    func mail(didFinishWith result: MailResult, error: Error?)
}

public class Mail: NSObject {
    
    public weak var delegate: MailDelegate?
    
    /**
     현재  ViewController
     */
    private var presented: UIViewController? {
        get {
            if let window = UIApplication.shared.keyWindow {
                return window.rootViewController
            }
            return nil
        }
    }
    
    /**
     메일 전송 가능 여부
     */
    private func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    /**
     메일 전송
     
     - Parameters:
        - to: 전송 할 메일 주소 목록
        - subject: Title
        - msg: Content
     */
    public func sendMail(_ to: [String], subject: String?, message msg: String?) {
        DispatchQueue.global().async {
            guard self.canSendMail() else {
                ELog("Mail services are not available")
                return
            }
            
            DispatchQueue.main.async {
                let composeVC = MFMailComposeViewController()
                composeVC.mailComposeDelegate = self
                
                composeVC.setToRecipients(to)
                composeVC.setSubject(subject ?? "")
                composeVC.setMessageBody(msg ?? "", isHTML: false)
                
                self.presented?.present(composeVC, animated: true, completion: nil)
            }
        }
    }
}

extension Mail: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        DispatchQueue.main.async {
            controller.dismiss(animated: true) { [weak self] in
                self?.delegate?.mail(didFinishWith: MailResult(value: result), error: error)
            }
        }
    }
}
