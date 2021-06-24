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
    let token = Account.user?.accessToken ?? ""
    let sig = Signature.generate(method: method, path: path, appId: Env.appId, token: token, param: parameters)
    var headers = sig.httpHeaders
    headers.append(HTTPHeader(field: .accept, value: "application/json"))
    headers.append(HTTPHeader(field: .contentType, value: "application/json"))
    return headers
  }
  
  var encoder: HTTPRequestEncoder { JSONHTTPRequestEncoder() }
}

extension Request: EndPoint {}


enum API {
  case login(Parameters)
  case profile
}

extension API: EndPoint {
  var baseURL: String { Env.baseURL }
  
  var path: String {
    switch self {
    case .login:
      return "/login/phone"
    case .profile:
    return "/users/profile"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .login:
      return .post
    default:
      return .get
    }
  }
  
  var parameters: Parameters? {
    switch self {
    case .login(let param):
      return param
    default:
      return nil
    }
  }
}

