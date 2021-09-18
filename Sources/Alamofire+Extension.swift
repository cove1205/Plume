//
//  Alamofire+Extension.swift
//  GQNetwork
//
//  Created by Cove on 2021/9/11.
//

import Foundation
import Alamofire

internal typealias Session = Alamofire.Session
internal typealias Request = Alamofire.Request
internal typealias DownloadRequest = Alamofire.DownloadRequest
internal typealias UploadRequest = Alamofire.UploadRequest
internal typealias DataRequest = Alamofire.DataRequest

internal typealias ParameterEncoding = Alamofire.ParameterEncoding
internal typealias JSONEncoding = Alamofire.JSONEncoding
internal typealias URLEncoding = Alamofire.URLEncoding

internal typealias DownloadResponse<Success> = Alamofire.AFDownloadResponse<Success>
internal typealias DataResponse<Success> = Alamofire.AFDataResponse<Success>

internal typealias ReachabilityManager = Alamofire.NetworkReachabilityManager

internal typealias HTTPHeaders = Alamofire.HTTPHeaders

public typealias RequestParameters = [String: Any]
public typealias RequestMethod = Alamofire.HTTPMethod
public typealias RequestHeaders = [String: String]
public typealias RequestMultipartFormData = Alamofire.MultipartFormData
public typealias DownloadDestination = Alamofire.DownloadRequest.Destination



