//
//  appTabView.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//

import SwiftUI



struct appTabView: View {
    @StateObject private var viewModel = AppTabViewModel()

    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            locationMapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            locationListview()
                .tabItem {
                    Label("Locations", systemImage: "toilet")
                }
            AddLocationView()
                .tabItem {
                    Label("Add Restroom", systemImage: "plus.magnifyingglass")
                }
           
        }
             .onAppear {
                 viewModel.checkIfSawOB()
             }
             .accentColor(.brandprimary)
             .sheet(isPresented: $viewModel.isShowingOBView) {
                 onBoardView()
             }
         }
     }

     struct ContentView_Previews: PreviewProvider {
         static var previews: some View {
             appTabView()
         }
     }
