//
//  RoomListViewModel.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/24.
//

import SwiftUI
import Combine

let dateFormatter = DateFormatter()

final class RoomListViewModel: ObservableObject {
  @Published var rooms: [Room] = []
  private var subscribers: Set<AnyCancellable> = []
  
  func fetchRooms() {
    let date = Date().dateStr
    request(API.rooms(date: date, storeId: 1)).sink { completion in
      print(completion)
    } receiveValue: { [weak self] (rooms: [Room]) in
      self?.rooms = rooms.map { Room(room: $0, date: date)}
    }.store(in: &subscribers)

  }
}
 
extension Date {
  var dateStr: String {
    dateFormatter.dateFormat = "YYYY-MM-dd"
    return dateFormatter.string(from: Date())
  }
}

extension String {
  var date: Date {
    dateFormatter.dateFormat = "YYYY-MM-dd"
    return dateFormatter.date(from: self) ?? Date()
  }
}
