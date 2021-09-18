//
//  PlumeError.swift
//  GQNetwork
//
//  Created by Cove on 2021/9/3.
//

import Foundation

/// 请求的错误反馈
public enum PlumeError: Error {
    
    /// error when parameter encoding
    case parameterEncoding(Error)
    
    /// Indicates a response failed due to an underlying `Error`.
    case underlying(Error)
    
    case responseFaild(String)
    
    /// Indicates that Encodable couldn't be encoded into Data
    case encodableMapping(Error)

    /// Indicates that
    case responseDecoding

    
}

extension PlumeError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parameterEncoding(let error):
            return error.localizedDescription
        case .underlying(let err):
            return err.localizedDescription
        default: return "error"
        }
    }
}
