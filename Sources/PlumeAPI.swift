//
//  APIType.swift
//  GQNetwork
//
//  Created by Cove on 2021/6/9.
//

import Foundation

/// 请求行为
public enum RequestTask {
    
    /// 普通请求
    case request(parameters: RequestParameters? = nil)
    
    /// 上传文件
    case uploadFile(file: URL)

    /// 上传form-data
    case uploadMultipart(multipart: RequestMultipartFormData)

    /// 下载请求
    case download(parameters:RequestParameters? = nil, savePath: String)
}

/// 接口实现协议
public protocol PlumeAPI {
    
    /// 服务端IP或域名
    var host: String? { get }
    
    /// 请求路径
    var path: String { get }
    
    /// 请求方法
    var method: RequestMethod { get }
    
    /// 请求模式
    var task: RequestTask { get }
    
    /// 请求头
    var headers: RequestHeaders? { get }
    
}

/// 默认值
extension PlumeAPI {
    
    public var host: String? { return nil }
    
    var url: String {
        return host != nil ? host! + path : path
    }
    
    public var headers: [String: String]? { return nil }
    
}

