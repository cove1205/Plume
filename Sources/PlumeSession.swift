//
//  GQSession.swift
//  GQNetwork
//
//  Created by Cove on 2021/9/6.
//

import Foundation


public class PlumeSession {
    
    /// 管理当前进行中的请求
    private var requests = [String:PlumeRequest]()
    
    private let session: Session!
    
    /// 配置
    private let config: PlumeConfiguration
    
    /// 拦截器
    private let interceptors: [PlumePlugin]
    
    /// 是否显示log
    private let showLog: Bool
    
    
    /// 构造方法
    /// - Parameters:
    ///   - config: 配置NetWorkConfig
    init(config: PlumeConfiguration) {
        
        self.config = config
        self.interceptors = config.interceptors
        self.showLog = config.showLog
        
        let defaultConfig = URLSessionConfiguration.af.default
        defaultConfig.timeoutIntervalForRequest = config.timeoutInterval  // Timeout interval
        defaultConfig.timeoutIntervalForResource = config.timeoutInterval   // Timeout interval
        
        self.session = Session(configuration: defaultConfig)
        
    }
    
    /// 取消所有请求
    public func cancelAllRequests() {
        session.cancelAllRequests(completingOnQueue: .main) {
            self.requests.removeAll()
            if self.showLog {
                debugPrint("cancel all requests")
            }
        }
    }
    
    /// 取消请求
    public func cancelRequest(request: PlumeRequest){
        request.cancel()
        self.requests.removeValue(forKey: request.id)
        if showLog {
            debugPrint("cancel request: \(request.id)")
        }
    }
    
    /// 生成GQRequest
    private func makeNetworkRequest(_ api: PlumeAPI) -> PlumeRequest {

        var afRequest: Request!
        
        // handle encoding
        let encoding: ParameterEncoding!
        if api.method == RequestMethod.post{
            encoding = JSONEncoding.default
        } else {
            encoding = URLEncoding.default
        }
        
        // handle headers
        let headers: HTTPHeaders? = api.headers != nil
            ? HTTPHeaders.init(api.headers!)
            : nil
        
        switch api.task {
        case .request(let paras):
            afRequest = session.request(api.url, method: api.method, parameters: paras, encoding: encoding, headers: headers)
        case .download(let paras, let savePath):
            afRequest = session.download(api.url, method: api.method, parameters: paras, encoding: encoding, headers: headers, to:  { _, res in
                return (URL(fileURLWithPath: savePath), options: [.createIntermediateDirectories, .removePreviousFile])
            })
        case .uploadFile(let url):
            afRequest = session.upload(url, to: api.url)
        case .uploadMultipart(let multipart):
            afRequest = session.upload(multipartFormData: multipart, to: api.url)
        }
        
        var networkRequest = PlumeRequest(api, afRequest)
        
        interceptors.forEach({
            networkRequest = $0.beforRequest(request: networkRequest, api: api)
        })
        
        self.requests.updateValue(networkRequest, forKey: networkRequest.id)
        
        return networkRequest
        
    }
    
    private func handleCompletion<R>(progress: ProgressClosure? = nil, success: SuccessClosure<R>? = nil, failed: FailedClosure? = nil) -> RequestableCompletion<R>{
        
        let com: RequestableCompletion<R> = {
            
            let pro: ProgressClosure = {
                p in
                progress?(p)
            }
            
            let s: SuccessClosure<R> = { res in
                
                success?(res)
            }
            
            let f: FailedClosure = { err in
                
                failed?(err)
                
            }
            
            return (pro, s, f)
            
        }
        return com
        
    }

    private func removeNetworkRequest(_ networkRequest: PlumeRequest){
        self.requests.removeValue(forKey: networkRequest.id)
    }
}

extension PlumeSession {
    
    @discardableResult
    public func request(_ api: PlumeAPI, progress: ProgressClosure? = nil, success: SuccessClosure<Data>? = nil, failed: FailedClosure? = nil) -> PlumeRequest? {
        
        return makeNetworkRequest(api).response(handleCompletion(progress: progress ,success: success, failed: failed))
    }
    
    @discardableResult
    public func requestJson(_ api: PlumeAPI, progress: ProgressClosure? = nil, success: SuccessClosure<Any>? = nil, failed: FailedClosure? = nil) -> PlumeRequest? {
        
        return makeNetworkRequest(api).responseJson(handleCompletion(progress: progress ,success: success, failed: failed))
    }
    
    @discardableResult
    public func requestModel<T: Decodable>(_ api: PlumeAPI, resType: T.Type, progress: ProgressClosure? = nil, success: SuccessClosure<T>? = nil, failed: FailedClosure? = nil) -> PlumeRequest? {
        
        return makeNetworkRequest(api).responseModel(of: resType, completion: handleCompletion(success: success, failed: failed))
    }
    
}
