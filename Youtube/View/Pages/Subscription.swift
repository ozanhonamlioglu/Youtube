//
//  Subscription.swift
//  Youtube
//
//  Created by ozan honamlioglu on 11.05.2021.
//

import SwiftUI

struct Subscription: View {
    @ObservedObject var vm: VMTabBarListFeed = VMTabBarListFeed(feed: .subscription, dataStore: subscriptionDataStore)
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

struct Subscription_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            
            Subscription()
        }
        .preferredColorScheme(.dark)
    }
}
