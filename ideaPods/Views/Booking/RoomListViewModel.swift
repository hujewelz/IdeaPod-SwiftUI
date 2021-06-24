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
    dateFormatter.dateFormat = "YYYY-MM-dd"
    let date = dateFormatter.string(from: Date())
    request(API.rooms(date: date, storeId: 1)).sink { completion in
      print(completion)
    } receiveValue: { [weak self] (rooms: [Room]) in
      self?.rooms = rooms
      print(rooms)
    }.store(in: &subscribers)

  }
}
 
