//
//  RoomPayment.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/25.
//

import SwiftUI

struct RoomPayment: View {
  @ObservedObject var viewModel: RoomPaymentViewModel
  
  var body: some View {
    VStack(spacing: 0) {
      ScrollView {
        roomInfo
        Divider()
        payInfo
      }
      .padding()
      payButton
    }
  }
  
  private var roomInfo: some View {
    VStack(spacing: 10) {
      HStack(alignment: .top) {
        Image("home_02")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 78, height: 55)
          .cornerRadius(6)
        
        VStack(alignment: .leading, spacing: 4) {
          Text(viewModel.room.title)
            .font(.title3)
          Text(viewModel.room.store.name)
            .font(.footnote)
            .foregroundColor(.secondary)
        }
        .padding(.top, 2)
        Spacer()
        HStack(spacing: 2) {
          Text("\(viewModel.room.point)")
            .font(.body.bold())
          Text("积分")
            .font(.caption)
        }
      }
      .padding(.bottom, 20)
      
      textRow(title: "预订时间", value: "2021-04-26  12:30-13:00")
      textRow(title: "地点", value: "北京市朝阳区通惠河北路郎家园6号郎园vintage3号楼1层")
      textRow(title: "会议室人数", value: "1-\(viewModel.room.attrs.capacity)人")
    }
    .padding(.vertical)
  }
  
  private var payInfo: some View {
    VStack(spacing: 10)  {
      HStack {
        Text("优惠券")
          .foregroundColor(.primary.opacity(0.8))
          .font(.callout)
        Spacer()
        Text("暂无可用券")
          .font(.callout)
          .foregroundColor(.secondary)
      }
      HStack {
        Text("会员折扣")
          .foregroundColor(.primary.opacity(0.8))
          .font(.callout)
        Spacer()
        Text("无")
          .font(.callout)
          .foregroundColor(.secondary)
      }
      HStack(spacing: 2) {
        Text("小计")
          .foregroundColor(.primary.opacity(0.8))
          .font(.callout)
        Spacer()
        Text("\(viewModel.room.point)")
          .bold()
        Text("积分")
          .font(.footnote)
      }
    }
    .padding(.vertical)
  }
  
  private var payButton: some View {
    VStack(spacing: 0) {
      Divider()
      HStack {
        HStack(spacing: 2) {
          Text("实际支付：")
          Text("100")
            .font(.title)
            .foregroundColor(.red)
          Text("积分")
            .foregroundColor(.red)

        }
        Spacer()
        Button("支付", action: viewModel.pay) 
        .font(.callout)
        .foregroundColor(Color(.systemBackground))
        .frame(width: 90, height: 36)
        .background(Color.primary)
        .clipShape(RoundedRectangle(cornerRadius: 18))
      }
      .frame(height: 68)
      .padding(.horizontal)
    }
  }
  
  private func textRow(title: String, value: String) -> some View {
    HStack {
      Text(title)
        .foregroundColor(.primary.opacity(0.8))
        .font(.callout)
      Spacer()
      Text(value)
        .font(.callout)
        .multilineTextAlignment(.trailing)
        .padding(.leading, 100)
    }
  }
}

//struct PaymentView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomPayment()
//    }
//}
