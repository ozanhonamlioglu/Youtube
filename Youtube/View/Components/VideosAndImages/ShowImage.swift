//
//  ShowImage.swift
//  Youtube
//
//  Created by ozan honamlioglu on 5.05.2021.
//

import SwiftUI

struct ShowImage: View {
    @ObservedObject var imageLoader: VMImageLoader
    @Binding var loading: Bool?
    
    init(withURL url:String, loading: Binding<Bool?>) {
        imageLoader = VMImageLoader(urlString:url)
        self._loading = loading
    }

    var body: some View {
        Image(uiImage: imageLoader.image ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onReceive(imageLoader.$image, perform: { uiimg in
                if(uiimg != nil) {
                    loading = false
                }
            })
    }
}

struct ShowImage_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init(UIColor(named: "background")!).edgesIgnoringSafeArea(.all)
            
            ShowImage(withURL: "https://i.ytimg.com/vi/L3A8kdCk_fM/hqdefault.jpg", loading: .constant(false))
        }
        .preferredColorScheme(.dark)
    }
}
