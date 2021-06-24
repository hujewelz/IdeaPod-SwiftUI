//
//  ideaPodsApp.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/8.
//

import SwiftUI

@main
struct ideaPodsApp: App {
  var body: some Scene {
    WindowGroup {
      if Account.user != nil {
        ContentView()
      } else {
        LoginView()
      }
    }
  }
}
