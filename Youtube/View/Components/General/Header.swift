//
//  Header.swift
//  Youtube
//
//  Created by ozan honamlioglu on 4.05.2021.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            HStack {
                Image("youtube")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("Youtube")
                    .font(.system(.title2, design: .rounded))
                    .padding(-5)
            }
            
            Spacer()
            
            HStack(spacing: 15) {
                SysImageButton(buttonImageName: "laptopcomputer.and.iphone")
                SysImageButton(buttonImageName: "bell")
                SysImageButton(buttonImageName: "magnifyingglass")
                SysImageButton(buttonImageName: "person.crop.circle")
            }
        }
        .padding(.horizontal)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init(UIColor(named: "background")!).edgesIgnoringSafeArea(.all)
            
            Header()
        }
        .preferredColorScheme(.dark)
    }
}
