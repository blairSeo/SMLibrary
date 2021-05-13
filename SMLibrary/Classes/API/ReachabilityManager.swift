//
//  ReachabilityManager.swift
//
//  Created by 서상민 on 2021/05/12.
//

import Foundation
import Alamofire

public class ReachabilityManager {

    public static let shared = ReachabilityManager()
    
    /**
     네트워크 상태 Manager
     */
    private let manager = NetworkReachabilityManager(host: "www.apple.com")
    
    private let queue = DispatchQueue(label: "SMlibrary.Network.Status", qos: .background, attributes: .concurrent)
    
    /**
     네트워크 상태 Start Listener
     
     - Important:
     Main Thread에서 반환
     
     - Note:
        * 활용예제
            * App 전역에서 네트워크 상태값을 얻기 위해 해당 위치에서 요청.
                * application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? )
            * 네트워크 상태값에 따른 UI을 노출하기 위해 현재 ViewController를 얻어 옴.
                ```
                guard let root = UIApplication.shared.keyWindow?.rootViewController else { return }
     
                switch root {
                    case let navi as UINavigationController:
                        let visible = navi.visibleViewController
                    default:
                        let presented = root.presentedViewController ?? root
                }
                ```
     
     - Parameters:
        - CompletionHandler
        - status: 네트워크 상태 반환
     */
    public func startListening(completionHandler: @escaping (_ status: ConnectStatus) -> Void) {
        guard let manager = self.manager else {
            ELog("Alamofire >> NetworkReachabilityManager를 확인 해 주세요.")
            return
        }
        
        manager.startListening(onQueue: queue, onUpdatePerforming: { status in
            switch status {
            case .unknown, .notReachable:
                
                DispatchQueue.main.async {
                    completionHandler(.disconnect)
                }
            case .reachable(let connType):
                let type = ConnectStatus.ConnectType(connType)
                
                DispatchQueue.main.async {                
                    completionHandler(.connect(type))
                }
            }
        })
    }
    
    /**
     네트워크 상태 Stop Listener
     */
    public func stopListening() {
        guard let manager = self.manager else {
            ELog("Alamofire >> NetworkReachabilityManager를 확인 해 주세요.")
            return
        }
        
        manager.stopListening()
    }
}
