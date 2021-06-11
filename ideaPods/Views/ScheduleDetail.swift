//
//  ScheduleDetail.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/9.
//

import SwiftUI

struct ScheduleDetail: View {
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        Image("home_04")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(maxWidth: .infinity)
        
        buildHeader()
        
        VStack(alignment: .leading, spacing: 16) {
          Label("2021-04-26  10:30-12:00，90分钟", systemImage: "clock").font(.subheadline)
          Label("北京市朝阳区通惠河北路郎家园6号郎园vintage3号楼1层", systemImage: "location").font(.subheadline)
          Label("当天需要开一下新的需求评审会议", systemImage: "square.and.pencil").font(.subheadline)
          Label("300 积分", systemImage: "yensign.circle").font(.subheadline)
        }
        .padding()
        //      .padding(.horizontal)
        
        buildActionSection(title: "定制服务", desc: "会议结束前20分钟无法定制服务", buttonTitle: "选择")
        buildActionSection(title: "取消预订", desc: "预订取消规则", buttonTitle: "取消")
        Spacer()
        
        Button("分享邀请") {
          
        }
        .font(.callout)
        .frame(height: 46)
        .frame(maxWidth: .infinity)
        .foregroundColor(Color.white)
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 23))
        .padding(32)
      }
    }
    .edgesIgnoringSafeArea(.top)
    .navigationBarTitleDisplayMode(.inline)
  }
  
  private func buildHeader() -> some View {
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
      
      Divider()
        .padding(.top)
    }
    .padding(.horizontal)
  }
  
  private func buildActionSection(title: String, desc: String, buttonTitle: String) -> some View {
    HStack {
      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .font(.callout)
          .fontWeight(.medium)
        Text(desc)
          .font(.caption)
          .foregroundColor(.secondary)
      }
      Spacer()
      Button(buttonTitle) {
        
      }
      .font(.callout)
      .foregroundColor(Color(.systemBackground))
      .frame(width: 90, height: 36)
      .background(Color.primary)
      .cornerRadius(18)
    }
    .cardContent()
  }
}

extension View {
  func cardContent() -> some View  {
    self.padding()
      .background(Color(.systemGray6).opacity(0.5))
      .cornerRadius(6)
      .padding(.horizontal, 16)
  }
}

struct ScheduleDetailView_Previews: PreviewProvider {
    static var previews: some View {
      ScheduleDetail().preferredColorScheme(.dark)
      ScheduleDetail().preferredColorScheme(.light)
    }
}
