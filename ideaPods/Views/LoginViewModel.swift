//
//  LoginViewModel.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/21.
//

import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
  private var countdownValue = 59
  
  @Published var phone: String = ""
  @Published var code: String = ""
  @Published var veryCodeBtnTitle = "获取验证码"
  @Published var veryCodeBtnEnabled = true
  @Published var loginEnabled = false
  
  private var timer: AnyCancellable?
  private var dispose: Set<AnyCancellable> = []
  
  init() {
 
    $phone.combineLatest($code).sink { value in
      print(value)
    }.store(in: &dispose)

  }
  
  func countdown() {
    veryCodeBtnTitle = "59s"
    veryCodeBtnEnabled = false
    
    timer =  Timer.publish(every: 1, on: .main, in: .common)
      .autoconnect()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        guard let self = self else { return }
        self.countdownValue -= 1
        if self.countdownValue < 0 {
          self.countdownValue = 59
          self.timer?.cancel()
          self.veryCodeBtnEnabled = true
        }
        self.veryCodeBtnTitle = self.countdownValue >= 59 ? "获取验证码" : "\(self.countdownValue)s"
      }
  }
  
  func login() {
    
  }
}
