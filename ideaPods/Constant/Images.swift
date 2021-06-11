//
//  Images.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/8.
//

import SwiftUI

extension Image {
  
  enum TabBar {
    static let home = Image("home")
    static let schedule = Image(systemName: "timer")
    static let booking = Image(systemName: "square.stack.3d.up")
    static let mine = Image("mine")
  }
  
  enum Booking {
    static let people = Image("icon-booking-people")
    static let price = Image("icon-booking-price")
  }
}
