//
//  PlumeResponse.swift
//  Plume
//
//  Created by Cove on 2021/9/15.
//

public struct PlumeResponse<T>{

    public var statusCode: Int
    
    public var isSucceed: Bool
    
    public var data: T? = nil
    
    public var request: PlumeRequest?
    
    
    internal init(statusCode: Int = 200, isSucceed: Bool = true, request: PlumeRequest?, data: T?) {
        self.statusCode = statusCode
        self.isSucceed = isSucceed
        self.request = request
        self.data = data
    }
}
