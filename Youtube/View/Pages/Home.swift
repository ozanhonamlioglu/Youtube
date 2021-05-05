//
//  Home.swift
//  Youtube
//
//  Created by ozan honamlioglu on 4.05.2021.
//

import SwiftUI

struct Home: View {
    @ObservedObject var homeList: VMHomeFeed = VMHomeFeed()
    @State var loading: Bool = true
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            if (loading) {
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            }
            
            LazyVStack {
                if(!loading) {
                    ForEach(homeList.list!.items, id: \.self) { item in
                        LargeVideoPreview(
                            url: homeList.getImageUrl(thumbnails: item.snippet.thumbnails),
                            title: item.snippet.title,
                            channelName: item.snippet.channelTitle,
                            viewCount: item.statistics.viewCount
                        )
                    }
                }
            }
            
        }.onReceive(homeList.$list, perform: { list in
            if(list != nil) {
                loading = false
            }
        })
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
