//
//  HomeViewModel.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/24.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
  @Published var stores: [Store] = []
  @Published var currentStore: Store?
  @Published var isPresentedActionSheet = false
  
  private var subscribers: Set<AnyCancellable> = []
  
  func fetchData() {
    request(API.stores).sink { _ in
      
    } receiveValue: { [weak self] (stores: [Store]) in
      self?.stores = stores
      self?.currentStore = stores.first
    }.store(in: &subscribers)
  }
  
  func presetnActionSheet() {
    isPresentedActionSheet = true
  }
  
  func switchStore(_ store: Store) {
    currentStore = store
  }
}
