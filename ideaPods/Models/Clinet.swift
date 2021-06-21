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
  
  static func generate(method: HTTPMethod, path: String, appId: String, token: String) -> Signature {
    let timestamp = Int(Date().timeIntervalSince1970)
    let nonce = UUID().uuidString
    let body = ""
    let strToSign = """
      \(appId)\n
      \(token)\n
      \(method.rawValue)\n
      \(path)\n
      \(body)\n
      \(timestamp)\n
      \(nonce)\n
      """
    var hmac = HMAC<SHA256>(key: SymmetricKey(data: "Ideapod-MeshKit".data(using: .utf8)!))
    hmac.update(data: strToSign.data(using: .utf8)!)
    let result = hmac.finalize()
    let sign = Data(result).map { String(format: "%02hhx", $0)}.joined()
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
