//
//  ContentView.swift
//  Youtube
//
//  Created by ozan honamlioglu on 4.05.2021.
//

import SwiftUI

struct ContentView: View {
    @State var activeTab: TabButtons = .home
    @State var openAddModal = false
    
    init() {
        UINavigationBar.appearance().backgroundColor = .red
    }
    
    var body: some View {
        ZStack {
            VStack {
                Header()
                Spacer()
                
                switch activeTab {
                case .home:
                    Home()
                case .trending:
                    Trending()
                case .subs:
                    Subscription()
                case .lib:
                    Library()
                default:
                    ZStack {}
                }
                
                Spacer()
                Tabbar(activeTab: $activeTab, openAddModal: $openAddModal)
            }
            
            if(openAddModal) {
                AddModal(open: $openAddModal)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init(UIColor(named: "background")!).edgesIgnoringSafeArea(.all)
            
            ContentView()
        }
        .preferredColorScheme(.dark)
    }
}
