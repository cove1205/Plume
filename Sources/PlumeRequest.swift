//
//  PlumeRequest.swift
//  Plume
//
//  Created by Cove on 2021/9/15.
//

import Foundation

public typealias SuccessClosure<T> = (_ response: PlumeResponse<T>) -> Void

public typealias FailedClosure = (_ error: PlumeError) -> Void

public typealias ProgressClosure = (_ progress: Progress) -> Void

internal typealias RequestableCompletion<T> = () -> (ProgressClosure, SuccessClosure<T>, FailedClosure)

//internal protocol Requestable {
//    func response(_ completion: RequestableCompletion<Data>) -> Self
//}

public class PlumeRequest {
    
    public let url: String

    /// The HTTP method for the request.
    public let method: RequestMethod

    /// The `Task` for the request.
    public let task: RequestTask

    /// The HTTP header fields for the request.
    public let headers: RequestHeaders?
    
    public let id: String
    
    internal var request: Request
    
    init(_ api: PlumeAPI, _ afRequest: Request) {
        self.url = api.url
        self.headers = api.headers
        self.task = api.task
        self.method = api.method
        self.request = afRequest
        self.id = self.request.id.uuidString
    }
    
    /// 处理progress
    internal func handleProgress(progress: ProgressClosure? = nil) {
        
        let progressClosure: ProgressClosure = { p in
            let sendProgress: () -> Void = {
                progress?(p)
            }
            sendProgress()
        }

        // Perform the actual request
        switch request {
        case let downloadRequest as DownloadRequest:
            request = downloadRequest.downloadProgress(closure: progressClosure)
        case let uploadRequest as UploadRequest:
            request = uploadRequest.uploadProgress(closure: progressClosure)
        case let dataRequest as DataRequest:
            request = dataRequest.downloadProgress(closure: progressClosure)
        default: break
        }
        
        //return self
    }
    
    /// 处理download结果
    private func handleDownload<R>(_ handler: @escaping RequestableCompletion<R>) -> ((DownloadResponse<R>) -> Void) {
        
        let dwonloadClosure: ((DownloadResponse<R>) -> Void) = { [weak self] res in
            
            let (p, s, f) = handler()
            
            self?.handleProgress(progress: p)
            
            switch res.result {
            case .success(let data):
                let n = PlumeResponse(statusCode: res.response?.statusCode ?? 200, isSucceed: true, request: self!, data: data)
                s(n)
            case .failure(let error):
                f(PlumeError.underlying(error))
            }

        }
        
        return dwonloadClosure
        
    }
    
    /// 处理data的结果
    private func handleData<R>(_ handler: @escaping RequestableCompletion<R>) -> ((DataResponse<R>) -> Void) {

        let dataClosure: ((DataResponse<R>) -> Void) = { [weak self] res in
            
            
            let (p, s, f) = handler()
            

            self?.handleProgress(progress: p)
                
            switch res.result {
            case .success(let data):
                let n = PlumeResponse(statusCode: res.response?.statusCode ?? 200, isSucceed: true, request: self!, data: data)
                s(n)
            case .failure(let error):
                f(PlumeError.underlying(error))
            }
        }
        return dataClosure
    }
    
    /// 取消请求
    func cancel() {
        request.cancel()
    }
    
}

/// Equatable for `NetworkRequest`
extension PlumeRequest: Equatable{
    
    public static func == (lhs: PlumeRequest, rhs: PlumeRequest) -> Bool {
        return lhs.request.id == rhs.request.id
    }
}
 
extension PlumeRequest {
    
    /// 基础返回
    internal func response(_ completion: @escaping RequestableCompletion<Data>) -> Self {
        
        switch request {
        case let downloadRequest as DownloadRequest:
            downloadRequest.responseData(completionHandler: handleDownload(completion))
        case let dataRequest as DataRequest:
            dataRequest.responseData(completionHandler: handleData(completion))
        default:
            break
        }
        return self
    }
    
    
    /// 返回JSON类型
    internal func responseJson(_ completion: @escaping RequestableCompletion<Any>) -> Self {
        
        switch request {
        case let downloadRequest as DownloadRequest:
            downloadRequest.responseJSON(completionHandler: handleDownload(completion))
        case let dataRequest as DataRequest:
            dataRequest.responseJSON(completionHandler: handleData(completion))
        default:
            break
        }
        return self
    }
    
    /// 返回指定Model类型
    internal func responseModel<T: Decodable>(of type: T.Type, completion: @escaping RequestableCompletion<T>) -> Self {
        
        switch request {
        case let downloadRequest as DownloadRequest:
            downloadRequest.responseDecodable(of: T.self, completionHandler: handleDownload(completion))
        case let dataRequest as DataRequest:
            dataRequest.responseDecodable(of: type, completionHandler: handleData(completion))
        default:
            break
        }
        return self
    }
    
}
