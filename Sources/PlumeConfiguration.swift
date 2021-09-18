//
//  PlumeConfiguration.swift
//  Plume
//
//  Created by Cove on 2021/9/13.
//

import Foundation

public struct PlumeConfiguration {
    
    /// 是否显示log
    public let showLog: Bool
    
    /// 超时时间
    public let timeoutInterval: TimeInterval
    
    /// 默认host地址
    public let baseHost: String?
    
    /// 中间件
    public let interceptors: [PlumePlugin]
    
    
    public init(baseHost:String? = nil, timeout: TimeInterval = 15, showLog: Bool = true, interceptors: [PlumePlugin] = []) {
        
        self.baseHost = baseHost
        self.timeoutInterval = timeout
        self.showLog = showLog
        self.interceptors = interceptors

    }
    
}
