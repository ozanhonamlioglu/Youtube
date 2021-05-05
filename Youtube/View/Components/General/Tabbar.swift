//
//  Tabbar.swift
//  Youtube
//
//  Created by ozan honamlioglu on 4.05.2021.
//

import SwiftUI

struct Tabbar: View {
    var body: some View {
        HStack() {
            SysImageButton(buttonImageName: "house.fill", buttonLabel: "Home")
            
            Spacer()
            
            SysImageButton(buttonImageName: "safari", buttonLabel: "Trending")
            
            Spacer()
            
            SysImageButton(buttonImageName: "plus.circle", buttonLabel: nil, iconAndTextFontStyle: [.icon: .system(size: 30)])
            
            Spacer()
            
            SysImageButton(buttonImageName: "rectangle.stack", buttonLabel: "subscription")
            
            Spacer()
            
            SysImageButton(buttonImageName: "play.rectangle", buttonLabel: "Library")
        }.padding(.horizontal)
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init(UIColor(named: "background")!).edgesIgnoringSafeArea(.all)
            
            Tabbar()
        }
        .preferredColorScheme(.dark)
    }
}
