//
//  RoomList.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/11.
//

import SwiftUI

struct RoomList: View {
    var body: some View {
      NavigationView {
        VStack() {
          DateSelector()
          Spacer()
          ScrollView {
            LazyVStack {
              RoomCell()
            }
            .padding()
          }
          .background(Color(.systemGroupedBackground))
          .edgesIgnoringSafeArea(.bottom)
        }
        .navigationTitle("预订")
        .navigationBarTitleDisplayMode(.inline)
      }
      .navigationBarBackgroundColor(UIColor.systemBackground)
    }
}

struct DateSelector: View {
  var body: some View {
    HStack {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(0...6, id: \.self) { index in
            VStack(spacing: 4) {
              Text("周\(index)").font(.callout).foregroundColor(.gray)
              Text("\(index + 20)").font(.callout).foregroundColor(.gray)
            }
            .padding()
          }
        }
//        .background(Color.red)
        .padding(.horizontal)
      }
      Button (action: {
        
      }, label: {
        Image(systemName: "calendar")
          .foregroundColor(.primary)
      })
      .padding(.horizontal)
    }
    .frame(maxWidth: .infinity)
//    .background(Color.yellow)
  }
}


struct RoomCell: View {
  var body: some View {
      VStack(alignment: .leading) {
        Image("home_03")
          .resizable()
          .frame(height: 175)
          .fixedSize()
          .aspectRatio(contentMode: .fill)
        
        VStack(alignment: .leading, spacing: 6) {
          Text("空中会议室")
            .font(.headline)
            .fontWeight(.medium)
          Text("ideaPod guomao")
            .foregroundColor(Color.primary.opacity(0.8))
            .font(.caption)
            .fontWeight(.thin)
          
          VStack(alignment: .leading, spacing: 4) {
            Label("可容纳 1-10 人", image: "icon-booking-people")
              .foregroundColor(Color.primary.opacity(0.8))
              .font(.caption)
            Label("400积分/灯泡 每小时", image: "icon-booking-price")
              .foregroundColor(Color.primary.opacity(0.8))
              .font(.caption)
          }
          .padding(.vertical, 10)
          
          TimeLine()
            .padding(.vertical, 10)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
      }
      .background(Color(.systemBackground))
      .cornerRadius(6)
    
  }
}

struct TimeLine: View {
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false, content: {
      TimeLineView()
//        .frame(height: 60)
    })
  }
}

struct RoomList_Previews: PreviewProvider {
    static var previews: some View {
      RoomList().preferredColorScheme(.light)
      RoomList().preferredColorScheme(.dark)
      TimeLine()
    }
}
