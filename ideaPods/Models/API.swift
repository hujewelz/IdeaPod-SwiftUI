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
  
  var httpHeaders: HttpHeaders? {
    let sig = Signature.generate(method: method, path: path, appId: Env.appId, token: "")
    return sig.httpHeaders
  }
  
  var encoder: HTTPRequestEncoder { JSONHTTPRequestEncoder() }
}

extension Request: EndPoint {}


enum API {
  case login(Parameters)
}

extension API: EndPoint {
  var baseURL: String { Env.baseURL }
  
  var path: String {
    switch self {
    case .login:
      return "/login/phone"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .login:
      return .post
    }
  }
  
  var parameters: Parameters? {
    switch self {
    case .login(let param):
      return param
    }
  }
}

