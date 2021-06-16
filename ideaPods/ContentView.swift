//
//  ContentView.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/8.
//

import SwiftUI

struct ContentView: View {
  @State private var selection: Tab = .home
  
  enum Tab {
    case home
    case schedule
    case booking
    case mine
  }
  
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Image.TabBar.home
          Text("Home")
        }
        .tag(Tab.home)
      ScheduleView()
        .tabItem {
          Image.TabBar.schedule
          Text("Schedule")
        }
        .tag(Tab.schedule)
      
      RoomList()
        .tabItem {
          Image.TabBar.booking
          Text("Booking")
        }
        .tag(Tab.booking)
      MineView()
        .tabItem {
          Image.TabBar.mine
          Text("Mine")
        }
        .tag(Tab.mine)
    }
    .tabViewStyle(DefaultTabViewStyle())
    .accentColor(.primary)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
        .preferredColorScheme(.light)
      ContentView()
        .preferredColorScheme(.dark)
      
    }
    
  }
}
