//
//  APNs.swift
//
//  Created by 서상민 on 2021/05/07.
//

import Foundation

/// Apple Push Notification Service 관련 기능
open class APNs: NSObject {
    
    /**
     알림설정 정보 조회
     
     - Parameter completion: 현재 알림설정 정보를 조회 후 호출하는 블럭이며, 알림설정 정보를 반환
     - Parameter setting: [UNNotificationSettings](https://developer.apple.com/documentation/usernotifications/unnotificationsettings)
     */
    public static func authorizationStatus(completion: @escaping (_ setting: UNNotificationSettings) -> Void) {
        unowned let current = UNUserNotificationCenter.current()
        current.getNotificationSettings { settings in
            completion(settings)
        }
    }
    
    /**
     Remote APNs 등록
     
     - Parameters:
        - application: [UIApplication](https://developer.apple.com/documentation/uikit/uiapplication)
        - options: 권한요청 옵션
     */
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
    
    private func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let request = notification.request
        ILog(request)
        
        completionHandler([.sound])
    }
    
    private func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        ILog(response)
        
        completionHandler()
    }
    
    private func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        ILog("")
    }
}
