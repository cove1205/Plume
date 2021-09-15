//
//  ReachabilityManager.swift
//  GQNetwork
//
//  Created by Cove on 2021/5/28.
//
import Foundation

//MARK: - 网络状态监控类
public class Reachability {
    
    /// 网络状态
    public enum ReachabilityStatus {
        /// 未知
        case unknown
        /// 网络不可用
        case notReachable
        /// Ethernet or WiFi.
        case ethernetOrWiFi
        /// 蜂窝网络
        case cellular
    }

    /// 监听网络状态变化
    public func startMonitoring(onUpdate: @escaping (ReachabilityStatus) -> Void) {
        manager.startListening(onQueue: .main, onUpdatePerforming: { [self] (status) in
            
            switch status {
            case .notReachable:
                networkStatus = .notReachable
            case .unknown:
                networkStatus = .unknown
            case .reachable(.ethernetOrWiFi):
                networkStatus = .ethernetOrWiFi
            case .reachable(.cellular):
                networkStatus = .cellular
            }
            
            // updating block
            onUpdate(networkStatus)
            
        })
    }
    
    /// 结束监听
    public func stopMonitoring() {
        manager.stopListening()
    }
    
    init() {
        self.manager = ReachabilityManager.default
    }
    
    /// 当前网络状态
    private(set) var networkStatus: ReachabilityStatus = .unknown

    /// 下层ReachabilityManager封装
    private let manager: ReachabilityManager!
    
}
