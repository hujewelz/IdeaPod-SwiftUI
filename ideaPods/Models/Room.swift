//
//  Room.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/24.
//

import Foundation

/// 0...48
typealias TimeRange = (start: Int, end: Int)

struct Room: Codable, Identifiable {
  let id: Int
  let productId: Int
  let title: String
  let cover: String
  let images: [String]
  let price: Int
  let point: Int
  let bulb: Int
  let discountPrice: Int
  let discountPoint: Int
  let discountBulb: Int
  let stock: Int
  let store: Store
  let attrs: Attrs
  let cancelRule: String
  let timeline: [Timeline]
  let discountStartedAt: String
  var date: String?
  
  struct Attrs: Codable {
    /// 可容纳人数
    let capacity: String
    /// 最大邀请人数
    let inviteLimit: String
  }
  
  struct Timeline: Codable {
    let date: String // "2021-05-08"
    let startedAt: String // "10:30"
    let finishedAt: String // "12:00"
    
    var timeRange: TimeRange {
      return (startedAt.timeIndex, finishedAt.timeIndex)
    }
  }
}

extension Room {
  var timeRanges: [TimeRange] {
    timeline.map { $0.timeRange }
  }
}

extension Room {
  init(room: Room, date: String) {
    id = room.id
    productId = room.productId
    title = room.title
    cover = room.cover
    images = room.images
    price = room.price
    point = room.point
    bulb = room.bulb
    discountPrice = room.discountPrice
    discountPoint = room.discountPoint
    discountBulb = room.discountBulb
    stock = room.stock
    store = room.store
    attrs = room.attrs
    cancelRule = room.cancelRule
    timeline = room.timeline
    discountStartedAt = room.discountStartedAt
    self.date = date
  }
}

extension String {
  /// return index of time. An houre is 2, and half is 1.
  ///
  /// Example:
  /// timeIndex of `"12:30"` returns `25 = 12 * 2 + 1`
  var timeIndex: Int {
    let seprated = split(separator: ":")
    guard seprated.count == 2 else {
      return 0
    }
    guard let hour = Int(seprated[0])
          , let minute = Int(seprated[1]) else {
      return 0
    }
    var index = hour * 2
    if minute == 30 {
      index += 1
    }
    return min(index, 48)
  }
}

extension Calendar {
  var currentTime: (day: Int, hour: Int, minute: Int) {
    let calendar = Calendar.current
    let components = calendar.dateComponents(in: .current, from: Date())
    return (components.day ?? 0, components.hour ?? 0, components.minute ?? 0)
  }
}
