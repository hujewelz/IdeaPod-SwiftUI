//
//  RoomDetail.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/11.
//

import SwiftUI

struct RoomDetail: View {
  @ObservedObject var viewModel: RoomDetailViewModel
  @State private var isActive = false
  
  var body: some View {
    VStack(spacing: 0) {
      content
      bottomBar
    }
    .customNavigationBar()
  }
  
  private var requirements: [(String, String)] {
    return [
      ("白板", "icon-whiteboard"),
      ("电视", "icon-tv"),
      ("投影", "icon-projector")
    ]
  }
  
  private func buildSection<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
    VStack(alignment: .leading, spacing: 0) {
      VStack(alignment: .leading, spacing: 8) {
        Text(title)
        content()
      }
      .padding()
      Spacer()
      separator()
    }
  }
  
  private var bottomBar: some View {
    VStack(spacing: 0) {
      Divider()
      HStack {
        VStack(alignment: .leading, spacing: 2) {
          HStack(spacing: 4) {
            Text("\(viewModel.room.point)")
            Text("积分/灯泡")
              .font(.caption)
          }
          Text("当前时段无优惠")
            .foregroundColor(.secondary)
            .font(.caption)
        }
        Spacer()
        NavigationLink(destination: RoomPayment(viewModel: RoomPaymentViewModel(room: viewModel.room)), isActive: $isActive) {
          Button("提交") {
            isActive.toggle()
          }
          .font(.footnote)
          .foregroundColor(Color(.systemBackground))
          .frame(width: 90, height: 36)
          .background(Color.primary)
          .clipShape(RoundedRectangle(cornerRadius: 18))
        }
      }
      .padding(.horizontal)
      .frame(height: 68)
    }
  }
  
  private var content: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 0) {
        Image("home_04")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(height: 230)
          .frame(maxWidth: .infinity)
          .clipped()
        
        VStack(alignment: .leading, spacing: 6) {
          Text(viewModel.room.title)
            .font(.title3)
            .fontWeight(.medium)
          
          Label(viewModel.room.store.name, systemImage: "building.2.crop.circle")
            .foregroundColor(Color.primary.opacity(0.8))
            .font(.caption)
          
          Label("可容纳 1-\(viewModel.room.attrs.capacity) 人", image: "icon-booking-people")
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
          TimeLine(timeRanges: viewModel.room.timeRanges)
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
            Button(action: viewModel.presentDatePicker, label: {
              Text(viewModel.date.dateStr)
              Image(systemName: "chevron.right").font(.footnote)
            })
            .foregroundColor(.primary)
            .padding()
          }
          .padding(.horizontal)
          .sheet(isPresented: $viewModel.showsDatePicker) {
            DatePicker("选择预订日期", selection: $viewModel.date, in: viewModel.date...)
              .datePickerStyle(WheelDatePickerStyle())
          }
          
          separator()
        }
        
        buildSection(title: "地点") {
          HStack {
            Label(viewModel.room.store.address, systemImage: "location.fill")
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
              Image(systemName: "chevron.right").font(.subheadline)
            })
            .padding()
          }
          .font(.footnote)
          .foregroundColor(.primary)
        }
        
        buildSection(title: "配置&服务") {
          HStack(spacing: 36) {
            ForEach(requirements, id: \.self.0) { item in
              VStack(spacing: 4) {
                Image(item.1)
                  .foregroundColor(.primary.opacity(0.8))
                Text(item.0)
                  .font(.caption)
                  .foregroundColor(.secondary)
              }
            }
          }
        }
        
        buildSection(title: "会议说明") {
          TextEditor(text: .constant(""))
            .font(.subheadline)
            .frame(height: 80)
        }
        
        VStack(alignment: .leading, spacing: 8) {
          Text("会议取消规则")
          Text(viewModel.room.cancelRule)
            .font(.footnote)
        }
        .padding()
        
      } // end of VStack
    }
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

//struct RoomDetail_Previews: PreviewProvider {
//    static var previews: some View {
//      RoomDetail(room: <#Room#>).preferredColorScheme(.light)
//    }
//}
