//
//  Tabbar.swift
//  Youtube
//
//  Created by ozan honamlioglu on 4.05.2021.
//

import SwiftUI

enum TabButtons: String {
    case home, trending, add, subs, lib
}

struct Tabbar: View {
    @Binding var activeTab: TabButtons
    @Binding var openAddModal: Bool
    
    var body: some View {
        HStack() {
            
            SysImageButton(callback: {activeTab = .home}, buttonImageName: "house", activeButtonImageName: "house.fill", active: activeTab == TabButtons.home, buttonLabel: "Home")
            
            Spacer()
            
            SysImageButton(callback: {activeTab = .trending}, buttonImageName: "safari", activeButtonImageName: "safari.fill", active: activeTab == TabButtons.trending, buttonLabel: "Trending")
            
            Spacer()
            
            SysImageButton(callback: {openAddModal = true}, buttonImageName: "plus.circle", activeButtonImageName: "plus.circle.fill", active: activeTab == TabButtons.add, buttonLabel: nil, iconAndTextFontStyle: [.icon: .system(size: 30)])
            
            Spacer()
            
            SysImageButton(callback: {activeTab = .subs}, buttonImageName: "rectangle.stack", activeButtonImageName: "rectangle.stack.fill", active: activeTab == TabButtons.subs, buttonLabel: "subscription")
            
            Spacer()
            
            SysImageButton(callback: {activeTab = .lib}, buttonImageName: "play.rectangle", activeButtonImageName: "play.rectangle.fill", active: activeTab == TabButtons.lib, buttonLabel: "Library")
            
        }.padding(.horizontal)
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            
            Tabbar(activeTab: .constant(.home), openAddModal: .constant(false))
        }
        .preferredColorScheme(.dark)
    }
}
