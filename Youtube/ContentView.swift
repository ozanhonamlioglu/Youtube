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
    @State var showSearch = false
    
    init() {
        // UINavigationBar.appearance().backgroundColor = .red
    }
    
    var body: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            
            VStack {
                Header(showSearch: $showSearch)
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
                    EmptyView()
                }
                
                Spacer()
                Tabbar(activeTab: $activeTab, openAddModal: $openAddModal)
            }
            
            if openAddModal {
                AddModal(open: $openAddModal)
            }
            
            if showSearch {
                SearchView(showSearch: $showSearch)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            
            ContentView()
        }
        .preferredColorScheme(.dark)
    }
}
