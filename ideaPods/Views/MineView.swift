//
//  MineView.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/8.
//

import SwiftUI

struct MineView: View {
  var body: some View {
    NavigationView {
      GeometryReader { proxy in
        ScrollView {
          ZStack(alignment: .topLeading) {
            Image("mine-bg")
              .resizable()
              .aspectRatio(375/270, contentMode: .fit)
            VStack(alignment: .leading) {
              header
              section1
                .padding(.top, 15)
              section2
                .padding(.top)
            }
            .padding()
            .padding(.top, proxy.safeAreaInsets.top + 40)
          }
        }
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea()
      }
      .navigationBarHidden(true)
    }
  }
  
  private var header: some View {
    HStack(spacing: 12) {
      Image(systemName: "person.circle")
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 52, height: 52)
        .clipShape(RoundedRectangle(cornerRadius: 13))
        .overlay(RoundedRectangle(cornerRadius: 13).stroke(Color(.systemBackground), lineWidth: 2))
      Text("超级灯泡人")
        .bold()
        .foregroundColor(Color(.systemBackground))
      Spacer()
      
      Button(action: {}, label: {
        Image("icon-edit")
          .padding()
      })
    }
  }
  
  private var section1: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack {
        VStack(alignment: .leading, spacing: 2) {
          Text("账户类型")
            .font(.caption)
          Text("注册会员")
        }
        .foregroundColor(Color(.systemBackground))
        Spacer()
      }
      .padding()
      .background(Color.yellow)
      HStack {
        VStack(alignment: .leading, spacing: 2) {
          Text("积分额度")
            .font(.caption)
          HStack {
            Text("3424")
              .font(.title3.bold())
            Button("充值") {}
              .font(.caption)
              .foregroundColor(Color(.systemBackground))
              .frame(width: 50, height: 22)
              .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8823264241, green: 0.6470906138, blue: 0.3097841144, alpha: 1)), Color(#colorLiteral(red: 0.7921447754, green: 0.5059071183, blue: 0.1607993543, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
              .cornerRadius(11)
          }
        }
        Spacer()
        Divider()
        
        VStack(spacing: 2) {
          Text("灯泡额度")
            .font(.caption)
          Text("0")
            .font(.title3.bold())
        }
        .padding(.leading, 24)
        Spacer()
      }
      .padding()
    }
    .background(Color(.systemBackground))
    .cornerRadius(6)
  }
  
  private var items: [CellItem] = [
    .init(id: 1, icon: "icon-gatepass", title: "购买畅行券"),
    .init(id: 2, icon: "icon-mycard", title: "我的卡券"),
    .init(id: 3, icon: "icon-record", title: "消费记录查询"),
    .init(id: 4, icon: "icon-invoce", title: "发票管理"),
    .init(id: 5, icon: "icon-feedback", title: "意见反馈"),
    .init(id: 6, icon: "icon-protocol", title: "条款规则"),
  ]
  private var section2: some View {
    LazyVStack(spacing: 0) {
      ForEach(items, id: \.id) { item in
        HStack(spacing: 12) {
          Image(item.icon)
          Text(item.title)
            
          Spacer()
          Image(systemName: "chevron.right")
            .font(.subheadline.bold())
            .foregroundColor(Color(.systemGray3))
        }
        .frame(height: 50)
      }
    }
    .padding()
    .background(Color(.systemBackground))
    .cornerRadius(6)
  }
}

extension MineView {
  struct CellItem {
    var id: Int
    var icon: String
    var title: String
  }
}

struct MineView_Previews: PreviewProvider {
  static var previews: some View {
    MineView().preferredColorScheme(.light)
  }
}
