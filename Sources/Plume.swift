//
//  Plume.swift
//  Plume
//
//  Created by Cove on 2021/9/15.
//  Copyright © 2021 Cove. All rights reserved.
//

// ============================================================================
public let PL = Plume.defalut
// ============================================================================


// MARK: - Plume
public class Plume {
    
    /// 网络状态管理器
    public let reachability: Reachability
    
    /// 请求管理器
    public let session: PlumeSession
    
    /// 配置
    public var configuration: PlumeConfiguration

    /// 默认构造方法
    public init(_ config: PlumeConfiguration) {
        configuration = config
        session = PlumeSession(config: config)
        reachability = Reachability()
    }
    
}

// MARK: - Plume Default
extension Plume {
    
    /// For singleton pattern
    public static let `defalut` = Plume()
    
    private convenience init() {
        let config = PlumeConfiguration()
        self.init(config)
        }
    
}




