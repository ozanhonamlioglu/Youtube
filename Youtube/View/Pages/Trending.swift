//
//  Trending.swift
//  Youtube
//
//  Created by ozan honamlioglu on 10.05.2021.
//

import SwiftUI

struct Trending: View {
    @ObservedObject var vm: VMTabBarListFeed = VMTabBarListFeed(feed: .trending, dataStore: trendingDataStore)
    @State var loading: Bool = true
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            if (loading) {
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            }
            
            VStack {
                if(!loading) {
                    ForEach(vm.list!.items, id: \.self) { item in
                        LargeVideoPreview(
                            url: vm.getImageUrl(thumbnails: item.snippet.thumbnails),
                            title: item.snippet.title,
                            channelName: item.snippet.channelTitle,
                            viewCount: item.statistics.viewCount,
                            publishedAt: item.snippet.publishedAt
                        )
                    }
                }
            }
            
        }.onReceive(vm.$list, perform: { list in
            if(list != nil) {
                loading = false
            }
        })
    }
}

struct Trending_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            
            Trending()
        }
        .preferredColorScheme(.dark)
    }
}