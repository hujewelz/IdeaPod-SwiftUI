//
//  User.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/21.
//

import Foundation

struct User: Codable {
  var userId: Int
  var accessToken: String
  var accessTokenExpiredAt: Int
}
