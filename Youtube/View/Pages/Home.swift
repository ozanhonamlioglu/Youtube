//
//  Home.swift
//  Youtube
//
//  Created by ozan honamlioglu on 4.05.2021.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ZStack {
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init(UIColor(named: "background")!).edgesIgnoringSafeArea(.all)
            
            Home()
        }
        .preferredColorScheme(.dark)
    }
}
