//
//  Library.swift
//  Youtube
//
//  Created by ozan honamlioglu on 11.05.2021.
//

import SwiftUI

struct Library: View {
    @ObservedObject var vm: VMTabBarListFeed = VMTabBarListFeed(feed: .library, dataStore: libraryDataStore)
    @State var loading: Bool = true
    
    var body: some View {

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
                        viewCount: item.statistics?.viewCount,
                        publishedAt: item.snippet.publishedAt
                    )
                }
            }
        }.onReceive(vm.$list, perform: { list in
            if(list != nil) {
                loading = false
            }
        })
        .modifier(TrackableScrollView())
        
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
