//
//  NavigationBarBackground.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/11.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
  var color: UIColor
  
  init(color: UIColor = .white) {
    self.color = color
    let apperance = UINavigationBarAppearance()
    apperance.configureWithOpaqueBackground()
    apperance.backgroundColor = color
    apperance.shadowImage = nil
    apperance.shadowColor = UIColor.clear
    
    UINavigationBar.appearance().standardAppearance = apperance
    UINavigationBar.appearance().compactAppearance = apperance
    UINavigationBar.appearance().scrollEdgeAppearance = apperance
    
  }
  
  func body(content: Content) -> some View {
    content
//    ZStack {
//      content
////      VStack {
////        GeometryReader { proxy in
////          Color(color)
////            .frame(height: proxy.safeAreaInsets.top)
////            .edgesIgnoringSafeArea(.top)
////          Spacer()
////        }
////      }
//    }
  }
}

extension View {
  func navigationBarBackgroundColor(_ color: UIColor = .white) -> some View {
    self.modifier(NavigationBarModifier(color: color))
  }
}
