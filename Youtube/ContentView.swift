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
    @State var showSearchPage = false
    
    init() {
        // UINavigationBar.appearance().backgroundColor = .gray // This is for navbar.
    }
    
    var body: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationView {
                    ZStack {
                        NavigationLink(
                            destination: SearchPage(showSearchPage: $showSearchPage),
                            isActive: $showSearchPage,
                            label: {
                                EmptyView()
                            })
                        
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
                            
                        }
                        
                    }
                    .background(Color("primary").edgesIgnoringSafeArea(.all))
                    .navigationBarHidden(true)
                }
                
                Spacer()
                Tabbar(activeTab: $activeTab, openAddModal: $openAddModal)
            }
            .ignoresSafeArea(.keyboard)
            
            if openAddModal {
                AddModal(open: $openAddModal)
            }
            
            if showSearch {
                SearchView(showSearch: $showSearch, showSearchPage: $showSearchPage)
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
