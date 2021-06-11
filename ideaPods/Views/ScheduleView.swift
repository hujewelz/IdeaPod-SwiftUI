//
//  ScheduleView.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/8.
//

import SwiftUI

struct ScheduleView: View {
  var body: some View {
    NavigationView {
      ScrollView {
        LazyVStack {
          ForEach(1...10, id: \.self) { count in
            NavigationLink(destination: ScheduleDetail()) {
              ScheduleCell()
            }
          }
        }
        .padding()
      }
      .navigationBarItems(trailing: Button(action: {}) {
        Image(systemName: "plus").foregroundColor(.primary)
      })
      .navigationTitle("2021年6月")
    }
  }
}

struct ScheduleCell: View {
  var body: some View {
    HStack(alignment: .top) {
      VStack {
        Text("周三").font(.caption)
        Text("09")
          .font(.title3.bold())
          .padding(.vertical, 1)
      }
      .padding(.trailing, 16)
      
      ZStack(alignment: .topLeading) {
        Text("我的预订")
          .font(.system(size: 10))
          .padding(.vertical, 2)
          .padding(.horizontal, 4)
          .background(Color.blue.opacity(0.4))
          .offset(x: -12, y: -12)
        
        HStack {
          VStack(alignment: .leading, spacing: 4) {
            Text("空中会议室")
              .font(.headline)
            Label("14:30-15:30  60分钟", systemImage: "clock")
              .font(.footnote)
            Label("ideaPod guomao", systemImage: "building.2.crop.circle")
              .font(.footnote)
          }
          Spacer()
          Color.yellow
            .frame(width: 99, height: 69)
            .cornerRadius(6)
        }
        .padding(.top, 8)
      }
      .padding(12)
      .background(Color.green.opacity(0.1))
      .cornerRadius(6)
    }
    .foregroundColor(Color.primary)
    .padding(.bottom, 8)
    
  }
}

struct ScheduleView_Previews: PreviewProvider {
  static var previews: some View {
    ScheduleView().preferredColorScheme(.dark)
    ScheduleView().preferredColorScheme(.light)
  }
}
