//
//  APNs.swift
//
//  Created by 서상민 on 2021/05/07.
//

import Foundation

open class APNs: NSObject {
    
    /// 알림설정 정보 조회
    ///
    /// - Parameter completion: 알림설정 정보 Closure
    ///     - UNNotificationSettings
    public static func authorizationStatus(completion: @escaping (UNNotificationSettings) -> Void) {
        unowned let current = UNUserNotificationCenter.current()
        current.getNotificationSettings { settings in
            completion(settings)
        }
    }
    
    /// Remote APNs 등록
    ///
    /// - Parameters:
    ///   - application: UIApplication
    ///   - options: 권한요청 옵션
    public func registerRemoteAPNs(application: UIApplication, add options: UNAuthorizationOptions = []) {
        DispatchQueue.global().async {
            unowned let current = UNUserNotificationCenter.current()
            current.delegate = self
            current.getNotificationSettings { settings in
                let authorize = settings.authorizationStatus
                
                switch authorize {
                case .notDetermined:
                    /// 사용자가 권한여부를 부여하지 않았을 경우
                    var authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                    authOptions.formUnion(options)
                    
                    current.requestAuthorization(options: authOptions) { (allow, error) in
                        if let error = error {
                            ELog(error: error)
                        }
                        
                        ILog(allow ? "알림 권한을 허락하였습니다." : "알림 권한을 허락하지 않았습니다.")
                    }
                    
                    DispatchQueue.main.async {
                        let isRegistered = application.isRegisteredForRemoteNotifications
                        guard isRegistered else {
                            application.registerForRemoteNotifications()
                            return
                        }
                    }
                case .denied:
                    /// 사용자가 권한취소 했을 경우
                    DispatchQueue.main.async {
                        let isRegistered = application.isRegisteredForRemoteNotifications
                        if isRegistered {
                            application.unregisterForRemoteNotifications()
                        }
                    }
                default:
                    return
                }
            }
        }
    }
}

extension APNs: UNUserNotificationCenterDelegate {
    
    /// App이 실행 중일 때 Notification 핸들링 부분
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let request = notification.request
        ILog(request)
        
        completionHandler([.sound])
    }
    
    /// App이 종료 중일 때 Notification 핸들링 부분
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        ILog(response)
        
        completionHandler()
    }
    
    /// In-App Notification설정
    /// 잠금화면 > [Swipe를 통해]App의 알림관리 > 알림설정
    public func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        ILog("")
    }
}
