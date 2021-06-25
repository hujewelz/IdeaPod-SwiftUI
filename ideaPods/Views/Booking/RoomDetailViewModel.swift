//
//  RoomDetailViewModel.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/24.
//

import SwiftUI

final class RoomDetailViewModel: ObservableObject {
  @Published var room: Room
  @Published var date: Date
  @Published var showsDatePicker = false
  
  init(room: Room) {
    self.room = room
    date = room.date?.date ?? Date()
  }
  
  func presentDatePicker() {
    showsDatePicker = true
  }
  
}
