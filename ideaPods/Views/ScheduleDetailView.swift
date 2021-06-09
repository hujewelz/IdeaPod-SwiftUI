//
//  ScheduleDetailView.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/9.
//

import SwiftUI

struct ScheduleDetailView: View {
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        HStack(alignment: .top) {
          VStack(alignment: .leading, spacing: 8) {
            Text("空中会议室")
              .font(.title3.bold())
            Label("ideaPod guomao", systemImage: "building.2.crop.circle")
              .foregroundColor(Color.secondary)
              .font(.footnote)
            Text("预订成功")
              .font(.caption.bold())
              .foregroundColor(Color(#colorLiteral(red: 0.3176470588, green: 0.6470588235, blue: 0.2823529412, alpha: 1)))
              .padding(.horizontal, 8)
              .padding(.vertical, 2)
              .background(Color(#colorLiteral(red: 0.3176470588, green: 0.6470588235, blue: 0.2823529412, alpha: 1)).opacity(0.14))
              .cornerRadius(2)
          }
          Spacer()
          Image("home_04")
            .resizable()
            .frame(width: 130, height: 90)
            .aspectRatio(contentMode: .fill)
            .cornerRadius(4)
        }
        
        Divider()
        
        Label("2021-04-26  10:30-12:00，90分钟", systemImage: "clock").font(.subheadline)
        Label("北京市朝阳区通惠河北路郎家园6号郎园vintage3号楼1层", systemImage: "location").font(.subheadline)
        Label("当天需要开一下新的需求评审会议", systemImage: "square.and.pencil").font(.subheadline)
        Label("300 积分", systemImage: "yensign.circle").font(.subheadline)
        
        Button("分享邀请") {
          
        }
        .font(.callout)
        .frame(height: 46)
        .frame(maxWidth: .infinity)
        .foregroundColor(Color.primary)
        .clipShape(RoundedRectangle(cornerRadius: 23))
        .overlay(RoundedRectangle(cornerRadius: 23).stroke(Color.primary, lineWidth: 1))
        .padding(.top, 8)
      }
      .cardContent()
      .padding(.vertical, 16)
      
      HStack {
        VStack(alignment: .leading, spacing: 4) {
          Text("定制服务")
            .font(.callout)
            .fontWeight(.medium)
          Text("会议结束前20分钟无法定制服务")
            .font(.caption)
            .foregroundColor(.secondary)
        }
        Spacer()
        Button("选择") {
          
        }
        .font(.callout)
        .foregroundColor(Color(.systemBackground))
        .frame(width: 90, height: 36)
        .background(Color.primary)
        .cornerRadius(18)
      }
      .cardContent()
      
      HStack {
        VStack(alignment: .leading, spacing: 4) {
          Text("取消预订")
            .font(.callout)
            .fontWeight(.medium)
          Text("预订取消规则")
            .font(.caption)
            .foregroundColor(.secondary)
        }
        Spacer()
        Button("取消") {
          
        }
        .font(.callout)
        .foregroundColor(Color(.red))
        .frame(width: 90, height: 36)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.red, lineWidth: 1))
      }
      .cardContent()
    }
    .navigationBarTitleDisplayMode(.inline)
    .background(Color(.systemGroupedBackground))
    .ignoresSafeArea(.all, edges: .bottom)
  }
}

extension View {
  func cardContent() -> some View  {
    self.padding()
        .background(Color(.systemBackground))
        .cornerRadius(6)
      .padding(.horizontal, 16)
  }
}

struct ScheduleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleDetailView()
    }
}
