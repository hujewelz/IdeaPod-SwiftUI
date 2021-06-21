//
//  LoginView.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/21.
//

import SwiftUI

struct LoginView: View {
  @StateObject private var viewModel = LoginViewModel()
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      VStack(alignment: .leading) {
        Text("Login Now")
          .font(.largeTitle.bold())
      }
      .padding(.bottom, 52)
      
      TextField("输入手机号", text: $viewModel.phone)
        .keyboardType(.phonePad)
        .font(.callout)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
      
      HStack {
        TextField("验证码", text: $viewModel.code)
          .keyboardType(.numberPad)
          .font(.callout)
          .padding()
        Button(viewModel.veryCodeBtnTitle, action: viewModel.countdown)
          .frame(width: 90)
          .disabled(!viewModel.veryCodeBtnEnabled)
          .font(.subheadline)
          .foregroundColor(.primary)
          .padding(.vertical)
      }
      .background(Color.gray.opacity(0.1))
      .cornerRadius(8)
      
      Button("登录", action: viewModel.login)
      .disabled(true)
      .foregroundColor(Color(.systemBackground))
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color.red)
      .cornerRadius(6)
      .padding(.top, 70)
    }
    .padding(.horizontal, 32)
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView().preferredColorScheme(.light)
    LoginView().preferredColorScheme(.dark)
  }
}
