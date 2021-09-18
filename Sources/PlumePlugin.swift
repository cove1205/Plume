//
//  PlumePlugin.swift
//  Plume
//
//  Created by Cove on 2021/9/15.
//

import Foundation

public protocol PlumePlugin {
    
    func beforRequest(request: PlumeRequest, api: PlumeAPI) -> PlumeRequest
    
    func afterResponse<T>(response: PlumeResponse<T>) -> PlumeResponse<T>
    
}

extension PlumePlugin {
    
    func beforRequest(request: PlumeRequest) -> PlumeRequest {
        return request
    }
    
    func afterResponse<T>(response: PlumeResponse<T>) -> PlumeResponse<T> {
        return response
    }
    
}
