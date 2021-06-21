//
//  RequestView.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/21.
//

import SwiftUI
import Combine

struct RequestView<M, E, Content>: View where M: Decodable, E: EndPoint, Content: View {
  
  private var content: (M) -> Content
  private var endPoint: E
  @State private var value: M?
  @State private var subscriber: AnyCancellable?
  @State private var msg = "Loading..."
  
  init(endPoint: E, @ViewBuilder content: @escaping (M) -> Content) {
    self.endPoint = endPoint
    self.content = content
  }
  
  
  var body: some View {
    Group {
      if let value = value {
        content(value)
      } else {
        VStack {
          Text("\(msg)")
            .font(.footnote)
        }
      }
    }
    .onAppear {
      subscriber = request(endPoint).sink { completion in
        switch completion {
        case .failure(let error):
          msg = error.localizedDescription
        case .finished:
          break
        }
      } receiveValue: { (value: M) in
        self.value = value
      }
    }
  }
  
  private func request<T>(_ endPoint: EndPoint) -> AnyPublisher<T, Error> where T: Decodable {
    let request = Request(baseURL: endPoint.baseURL,
                          path: endPoint.path,
                          method: endPoint.method,
                          parameters: endPoint.parameters,
                          httpHeaders: endPoint.httpHeaders,
                          encoder: endPoint.encoder)
    return fetch(request)
  }
}


