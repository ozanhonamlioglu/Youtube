//
//  SysImageButton.swift
//  Youtube
//
//  Created by ozan honamlioglu on 4.05.2021.
//

import SwiftUI

enum FontTypes: String {
    case icon
    case text
}

struct SysImageButton: View {
    var buttonImageName: String
    var buttonLabel: String?
    var iconAndTextFontStyle: [FontTypes?: Font]?
    
    var buttonStyle: Font? {
        if(iconAndTextFontStyle != nil) {
            for (key, val) in iconAndTextFontStyle! {
                if (key == .icon) {
                    return val
                }
            }
        }
        
        return .system(size: 20)
    }
    
    var textStyle: Font? {
        if(iconAndTextFontStyle != nil) {
            for (key, val) in iconAndTextFontStyle! {
                if (key == .text) {
                    return val
                }
            }
        }
        
        return .caption2
    }
    
    var body: some View {
        Button(action: {
            //
        }, label: {
            VStack {
                Image(systemName: buttonImageName)
                    .font(buttonStyle)
                if(buttonLabel != nil) {
                    Text(buttonLabel!)
                        .font(textStyle)
                }
            }.foregroundColor(Color("generalForeground"))
        })
    }
}

struct SysImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init(UIColor(named: "background")!).edgesIgnoringSafeArea(.all)
            
            SysImageButton(buttonImageName: "house.fill", buttonLabel: "Home")
        }
        .preferredColorScheme(.dark)
    }
}
