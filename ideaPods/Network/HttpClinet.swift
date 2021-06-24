//
//  Client.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/17.
//

import Foundation
import Combine
import CryptoKit

enum Env {
  static let appId = "wx6ea4c7deb97b4ee7"
  static let baseURL = "https://ideapod.meshkit.cn"
}

struct Signature {
  var token: String
  var appId: String
  var timestamp: Int
  var nonce: String
  var signature: String
  
  static func generate(request: URLRequest, appId: String, token: String) -> Signature {
    let timestamp = Int(Date().timeIntervalSince1970)*1000
    let nonce = UUID().uuidString
    var body = ""
    if let httpBody = request.httpBody,
       let decoded = String(data: httpBody, encoding: .ascii) {
      body = decoded
    }
    var path = request.url?.path ?? ""
    if let query = request.url?.query {
      path += "?\(query)"
    }
    let strToSign = """
    \(appId)
    \(token)
    \(request.httpMethod ?? "GET")
    \(path)
    \(body)
    \(timestamp)
    \(nonce)
    """
    var hmac = HMAC<SHA256>(key: SymmetricKey(data: "Ideapod-MeshKit".data(using: .utf8)!))
    hmac.update(data: strToSign.data(using: .ascii)!)
    let result = hmac.finalize()
    let sign = Data(result).base64EncodedString()
    return Signature(token: token, appId: appId, timestamp: timestamp, nonce: nonce, signature: sign)
  }
}

extension Signature {
  var httpHeaders: HttpHeaders {
    let headers: HttpHeaders = [
      .init(field: "Ideapod-App-Id", value: appId),
      .init(field: "Ideapod-Access-Token", value: token),
      .init(field: "Ideapod-Signature", value: signature),
      .init(field: "Ideapod-Timestamp", value: "\(timestamp)"),
      .init(field: "Ideapod-nonce", value: nonce),
    ]
    return headers
  }
}



final class NetworkClient<M, E>: ObservableObject where M: Decodable, E: EndPoint {
  @Published var value: M?
  private var subscriber: AnyCancellable?
  
  let endPoint: E
  
  init(endPoint: E) {
    self.endPoint = endPoint
  }
  
  func start() {
    subscriber = NetworkClient.request(endPoint).sink { [weak self] completion in
      switch completion {
      case .failure:
        self?.value = nil
      case .finished:
        break
      }
    } receiveValue: { [weak self] (value: M) in
      self?.value = value
    }
  }
  
  static func request<T>(_ endPoint: EndPoint) -> AnyPublisher<T, Error> where T: Decodable {
    let request = Request(baseURL: endPoint.baseURL,
                          path: endPoint.path,
                          method: endPoint.method,
                          parameters: endPoint.parameters,
                          httpHeaders: endPoint.httpHeaders,
                          encoder: endPoint.encoder)
    return fetch(request)
  }
}

func request<T>(_ endPoint: EndPoint) -> AnyPublisher<T, Error> where T: Decodable {
  let request = Request(baseURL: endPoint.baseURL,
                        path: endPoint.path,
                        method: endPoint.method,
                        parameters: endPoint.parameters,
                        httpHeaders: endPoint.httpHeaders,
                        encoder: endPoint.encoder)
  return fetch(request)
}
