//
//  Network.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/16.
//

import Foundation
import Combine


protocol URLRequestConvertible {
  func asURLRrequest() throws -> URLRequest
}

extension URL: URLRequestConvertible {
  func asURLRrequest() throws -> URLRequest {
    URLRequest(url: self)
  }
}

extension String: URLRequestConvertible {
  func asURLRrequest() throws -> URLRequest {
    guard let url = URL(string: self) else {
      throw URLError(.badURL)
    }
    return try url.asURLRrequest()
  }
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
}

typealias Parameters = [String: Any]

struct HTTPHeader {
  let field: String
  let value: String
  
  enum Field: String {
    case accept = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case cacheControl = "Cache-Control"
  }
}

extension HTTPHeader {
  init(field: HTTPHeader.Field, value: String) {
    self.field = field.rawValue
    self.value = value
  }
}

typealias HttpHeaders = [HTTPHeader]

struct Request: URLRequestConvertible {
  var baseURL = ""
  var path: String
  var method: HTTPMethod = .get
  var parameters: Parameters?
  var httpHeaders: HttpHeaders?
  var encoder: HTTPRequestEncoder
  
  func asURLRrequest() throws -> URLRequest {
    var request = try encoder.encode(self)
    request.httpMethod = method.rawValue
    
    let token = Account.user?.accessToken ?? ""
    let sig = Signature.generate(request: request, appId: Env.appId, token: token)
    var headers = sig.httpHeaders
    
    if let httpHeaders = httpHeaders {
      headers.append(contentsOf: httpHeaders)
      headers.forEach { header in
        request.addValue(header.value, forHTTPHeaderField: header.field)
      }
    }
    return request
  }
}

protocol HTTPRequestEncoder {
  func encode(_ request: Request) throws -> URLRequest
}

struct JSONHTTPRequestEncoder: HTTPRequestEncoder {
  func encode(_ request: Request) throws -> URLRequest {
    let urlStr = "\(request.baseURL)\(request.path)"
    
    guard var urlComponents = URLComponents(string: urlStr) else {
      throw URLError(.badURL)
    }
    
    var urlRequest: URLRequest!
    switch request.method {
    case .get:
      if let parameter = request.parameters {
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        queryItems += parameter.toQueryItem()
        urlComponents.queryItems = queryItems
      }
      urlRequest = URLRequest(url: urlComponents.url!)
    default:
      urlRequest = URLRequest(url: URL(string: urlStr)!)
      if let param = request.parameters {
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: param, options: [.fragmentsAllowed])
      }
    }
    return urlRequest
  }
}


extension Parameters {
  fileprivate func toQueryItem() -> [URLQueryItem] {
    var queryItems: [URLQueryItem] = []
    self.forEach { (key, value) in
      if let arr = value as? [Any] {
        queryItems += arr.map { URLQueryItem(name: key, value: String(describing: $0)) }
      } else {
        queryItems.append(URLQueryItem(name: key, value: String(describing: value)))
      }
    }
    return queryItems
  }
}

func log(request: URLRequest) {
  var msg = "\n\(request.httpMethod!) \(request.url!)\n"
  if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
    msg += headers.map { "\($0.key): \($0.value)"}.joined(separator: "\n")
  }
  if let body = request.httpBody,
     let json = try? JSONSerialization.jsonObject(with: body, options: [.mutableContainers, .allowFragments]) {
    msg += "\n\n\(String(describing: json))"
  }
  msg += "\n"
  print(msg)
}

func fetch<T>(_ request: URLRequestConvertible) -> AnyPublisher<T, Error> where T: Decodable {
  do {
    let httpRequest = try request.asURLRrequest()
    log(request: httpRequest)
    return URLSession.shared.dataTaskPublisher(for: httpRequest)
      .tryMap { ele -> Data in
        guard let httpResponse = ele.response as? HTTPURLResponse else {
          throw URLError(.badServerResponse)
        }
        if httpResponse.statusCode == 200 {
//          if let jsonObj = try? JSONSerialization.jsonObject(with: ele.data, options: []) {
//            print("👏RESULT: ", jsonObj)
//          }
          return ele.data
        }
        let errorData = try JSONDecoder().decode(ResponseError.self, from: ele.data)
        throw CustomError.serverError(errorData)
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  } catch let error {
    return Fail<T, Error>(error: error).eraseToAnyPublisher()
  }
}
