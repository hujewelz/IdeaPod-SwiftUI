//
//  RoomPaymentViewModel.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/25.
//

import SwiftUI
import Combine

final class RoomPaymentViewModel: ObservableObject {
  let room: Room
  
  private var subscribers: Set<AnyCancellable> = []
  
  init(room: Room) {
    self.room = room
  }
  
  func pay() {
    var param: Parameters = ["payMethod": "Point"]
    param["items"] = [[
      "skuId": room.productId,
      "count": 1
    ]]
    let meeting: Parameters = [
      "date": room.date ?? Date().dateStr,
      "startedAt": "18:00",
      "finishedAt": "19:30",
      "remark": "",
      "renew": false
    ]
    param["ext"] = [
      "meeting": meeting
    ]
    
    request(API.pay(param)).sink { completion in
      print(completion)
    } receiveValue: { (result: PayResult) in
      print(result)
    }
    .store(in: &subscribers)
  }
}


