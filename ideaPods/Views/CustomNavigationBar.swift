//
//  CustomNavigationBar.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/15.
//

import SwiftUI


struct CustomNavigationBarModifier: ViewModifier {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  func body(content: Content) -> some View {
    GeometryReader { proxy in
      ZStack(alignment: .top) {
        
          
        VStack(spacing: 0) {
          Spacer()
          navigationBar
            .frame(height: 44)
            .frame(maxWidth: .infinity)
        }
        .zIndex(999)
        .frame(height: 44 + proxy.safeAreaInsets.top)
        .frame(maxWidth: .infinity)
  
        content
      }
      .navigationBarHidden(true)
      .edgesIgnoringSafeArea(.top)
    }
  }
  
  private var navigationBar: some View {
    HStack {
      Button(action: {
        presentationMode.wrappedValue.dismiss()
      }, label: {
        Image(systemName: "chevron.backward")
          .font(.headline)
          .padding(.horizontal, 8)
//          .background(Color.white.clipShape(Circle())
//                        .frame(width: 38, height: 38).blur(radius: 3.0)
//          )
      })
      Spacer()
    }
    .padding()
  }
}

extension View {
  func customNavigationBar() -> some View {
    modifier(CustomNavigationBarModifier())
  }
}
