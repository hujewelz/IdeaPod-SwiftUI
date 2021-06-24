//
//  MineViewModel.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/24.
//

import SwiftUI
import Combine

final class MineViewModel: ObservableObject {
  @Published var profile: Profile?
  private var subscribers: Set<AnyCancellable> = []
  
  func fetchProfile() {
    request(API.profile).sink { completion in
      print(completion)
    } receiveValue: { [weak self] profile in
      self?.profile = profile
    }
    .store(in: &subscribers)
  }
}
