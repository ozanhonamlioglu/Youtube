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
    var callback: (() -> Void)?
    var buttonImageName: String
    var activeButtonImageName: String?
    var active: Bool?
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
    
    var imageString: String {
        if(active != nil && active != false) {
            if(activeButtonImageName != nil) {
                return activeButtonImageName!
            } else {
                return buttonImageName
            }
        }
        
        return buttonImageName
    }
    
    var body: some View {
        Button(action: {
            callback != nil ? (callback!)() : nil
            
        }, label: {
            VStack {
                Image(systemName: imageString)
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
            
            SysImageButton(callback: nil, buttonImageName: "house", activeButtonImageName: "house.fill", active: true, buttonLabel: "Home")
        }
        .preferredColorScheme(.dark)
    }
}
