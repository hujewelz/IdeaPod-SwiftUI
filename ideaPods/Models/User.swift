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

final class Account {
  static func store(_ user: User) {
    if let data = try? JSONEncoder().encode(user) {
      UserDefaults.standard.set(data, forKey: "loggedinuser")
      UserDefaults.standard.synchronize()
    }
  }
  
  static var user: User? {
    if let data = UserDefaults.standard.data(forKey: "loggedinuser")
       , let user = try? JSONDecoder().decode(User.self, from: data) {
      let expireDate = Date(timeIntervalSince1970: Double(user.accessTokenExpiredAt)/1000)
      if expireDate <= Date() {
        return nil
      }
      return user
    }
    return nil
  }
}
