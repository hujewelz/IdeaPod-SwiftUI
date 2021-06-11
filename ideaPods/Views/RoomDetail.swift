//
//  RoomDetail.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/11.
//

import SwiftUI

struct RoomDetail: View {
    var body: some View {
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          Image("home_04")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 230)
            .frame(maxWidth: .infinity)
            .clipped()
          
          VStack(alignment: .leading, spacing: 6) {
            Text("空中会议室")
              .font(.title3)
              .fontWeight(.medium)
            
            Label("ideaPod guomao", systemImage: "building.2.crop.circle")
              .foregroundColor(Color.primary.opacity(0.8))
              .font(.caption)
            
            Label("可容纳 1-10 人", image: "icon-booking-people")
              .foregroundColor(Color.primary.opacity(0.8))
              .font(.caption)
          }
          .padding()
          
          Group {
            separator()
            // time updated when select time
            HStack {
              Text("预定时段")
              Spacer()
              Text("10:30-11:30，60分钟")
            }
            .padding()
          }
          
          Group {
            // timeline view
            TimeLine()
              .padding(.horizontal)
            
            // unvaliable time
            HStack(spacing: 6) {
              Spacer()
              unvaliableTime
              Text("不可预定")
                .font(.caption2)
                
            }
            .padding()
            
            // date for booking
            HStack {
              Text("预定日期")
              Spacer()
              Button(action: {}, label: {
                Text("2021-04-26")
                Image(systemName: "chevron.right").font(.footnote)
              })
              .foregroundColor(.primary)
              .padding()
            }
            .padding(.horizontal)
            
            separator()
          }
          
          Group {
            VStack(alignment: .leading, spacing: 8) {
              Text("地点")

              HStack {
                Label("北京市朝阳区通惠河北路郎家园6号郎园vintage3号楼1层", systemImage: "location.fill")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                  Image(systemName: "chevron.right").font(.subheadline)
                })
                .padding()
              }
              .font(.footnote)
              .foregroundColor(.primary)
            }
            .padding()
            
            separator()
          }
          
          Group {
            VStack(alignment: .leading, spacing: 8) {
              Text("配置&服务")
            }
            .padding()
            separator()
          }
        } // end of VStack
      }
      .edgesIgnoringSafeArea(.top)
    }
  
  private var unvaliableTime: some View {
    Path { path in
      for i in 0...4 {
        path.move(to: CGPoint(x: i*2, y: 0))
        path.addLine(to: CGPoint(x: i*2, y: 10))
      }
    }
    .stroke(Color.primary, lineWidth: 0.5)
    .frame(width: 10, height: 10)
  }
  
  private func separator() -> some View {
    Divider()
      .background(Color.primary)
      .padding(.vertical, 8)
  }
}

struct RoomDetail_Previews: PreviewProvider {
    static var previews: some View {
        RoomDetail()
    }
}
