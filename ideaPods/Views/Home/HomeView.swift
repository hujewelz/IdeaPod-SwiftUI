//
//  HomeView.swift
//  ideaPods
//
//  Created by huluobo on 2021/6/8.
//

import SwiftUI

struct HomeView: View {
  @StateObject private var viewModel = HomeViewModel()
  
  var body: some View {
    NavigationView {
      ScrollView {
        Banner()
        HStack{
          Image(uiImage: #imageLiteral(resourceName: "icon_location")).foregroundColor(.primary)
          Text(viewModel.currentStore?.name ?? "")
          Spacer()
          Button(action: viewModel.presetnActionSheet, label: {
            Text("切换门店")
              .foregroundColor(Color.black)
              .font(.system(size: 12, weight: .medium))
            Image(uiImage: #imageLiteral(resourceName: "icon_switch_location"))
              .foregroundColor(.black)
          })
          .frame(width: 94, height: 28)
          .background(Color.yellow)
          .cornerRadius(14)
        }
        .padding()
        
        VStack(spacing: 0) {
          Card(title: "Title", subtitle: "Subtitle", img: "home_01")
          Card(title: "Title", subtitle: "Subtitle", img: "home_02")
          Card(title: "Title", subtitle: "Subtitle", img: "home_03")
        }
      }
      .navigationBarHidden(true)
      .ignoresSafeArea(.container, edges: .top)
      .actionSheet(isPresented: $viewModel.isPresentedActionSheet, content: actionSheet)
    }
    .onAppear {
      viewModel.fetchData()
    }
  }
  
  private func actionSheet() -> ActionSheet {
    var buttons = viewModel.stores
      .map { store in ActionSheet.Button.default(Text(store.name)) {
        viewModel.switchStore(store)
      } }
    buttons.append(.cancel())
    return ActionSheet(title: Text("切换门店"), message: nil, buttons: buttons)
  }
}

struct Card: View {
  let title: String
  let subtitle: String
  let img: String
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Image(img)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(height: 130)
        .clipped()
      VStack(alignment: .leading) {
        Text(title)
          .font(.title)
          .foregroundColor(.white)
        Text(subtitle)
          .font(.subheadline)
          .foregroundColor(.white)
      }
      .padding()
    }
  }
}

struct Banner: View {
  let images = ["home_03",  "home_04"]
  var body: some View {
    TabView {
      ForEach(images, id: \.self) { img in
        Image(img)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(maxWidth: .infinity)
          .clipped()
      }
    }
    .frame(height: 260)
    .frame(maxWidth: .infinity)
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    
//    ScrollView(.horizontal, showsIndicators: false) {
//      HStack(spacing: 0) {
//        ForEach(images, id: \.self) { img in
//          Image(img)
//            .resizable()
//            .scaledToFill()
//            .frame(width: 500, height: 260)
//            .clipped()
//        }
//      }
//    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .preferredColorScheme(.dark)
    HomeView()
      .preferredColorScheme(.light)
  }
}
