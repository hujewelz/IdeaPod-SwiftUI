//
//  Response.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/24.
//

import Foundation

struct ResponseError: Codable {
  let code: String
  let message: String
  let detail: String?
}

enum CustomError: Error {
  case serverError(ResponseError)
}
