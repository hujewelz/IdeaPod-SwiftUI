//
//  API.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/17.
//

import Foundation
import Combine

protocol EndPoint {
  var baseURL: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: Parameters? { get }
  var httpHeaders: HttpHeaders? { get }
  var encoder: HTTPRequestEncoder { get }
}

extension EndPoint {
  var method: HTTPMethod { .get }
  
  var parameters: Parameters? { nil }
  
  var httpHeaders: HttpHeaders? { nil }
  
  var encoder: HTTPRequestEncoder { JSONHTTPRequestEncoder() }
}

extension Request: EndPoint {}


enum API {
  case test
}

extension API: EndPoint {
  var path: String {
    "/test"
  }
  
  var baseURL: String { Env.baseURL }
  
  var httpHeaders: HttpHeaders? {
    let sig = Signature.generate(method: method, path: path, appId: Env.appId, token: "")
    return sig.httpHeaders
  }
}

