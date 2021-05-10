//
//  HomeFeed.swift
//  Youtube
//
//  Created by ozan honamlioglu on 5.05.2021.
//

import Foundation
import Alamofire
import SwiftDate

enum TabList: String {
    case home = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2C%20status%2C%20statistics%2C%20contentDetails%2C%20player%2C%20id&chart=mostPopular&maxResults=20&key=AIzaSyDUfYc0PuEgZMrZAg-mn9cZR46xEz7q5WA"
    case trending = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2C%20status%2C%20statistics&chart=mostPopular&maxResults=20&regionCode=tr&key=AIzaSyDUfYc0PuEgZMrZAg-mn9cZR46xEz7q5WA"
    case subscription = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2C%20status%2C%20statistics&chart=mostPopular&maxResults=20&regionCode=tr&videoCategoryId=2&key=AIzaSyDUfYc0PuEgZMrZAg-mn9cZR46xEz7q5WA"
    case library = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2C%20status%2C%20statistics&chart=mostPopular&maxResults=20&regionCode=tr&videoCategoryId=1&key=AIzaSyDUfYc0PuEgZMrZAg-mn9cZR46xEz7q5WA"
}

class VMTabBarListFeed: ObservableObject {
    @Published var list: MVideos?
    
    init(feed: TabList, dataStore: DataStoreProtocol) {
        getList(feed: feed, dataStore: dataStore)
    }
    
    func getList(feed: TabList, dataStore: DataStoreProtocol) {
        if (dataStore.getList() == nil) {
            AF.request(feed.rawValue, encoding: JSONEncoding.default).validate().responseJSON { response in
                if (response.error != nil) { return }
                
                do {
                    let videos = try JSONDecoder().decode(MVideos.self, from: response.data!)
                    self.list = videos
                    dataStore.setList(list: videos)
                    
                } catch {
                    print("decoder error \(error.localizedDescription), \(error)")
                }
            }
        } else {
            list = dataStore.getList()
        }
    }
    
    func refreshFeed() {
        print("Refresh occured")
    }
    
    func getImageUrl(thumbnails: MVideosItemsSnippetThumbNails) -> String {
        
        if let url = thumbnails.maxres?.url {
            return url
        }
        
        return thumbnails.high.url
    }
    
    public static func getModifiedViewCountString(views: String?) -> String {
        
        if (views == nil) { return "0" }
        
        // 999.999 -> (999K) 6 chars
        // 999.999.999 -> (999M) 9 chars
        // x.999.999.999 -> (xB) >9 chars
        var theChars = views!
        
        if(theChars.count >= 4 && theChars.count <= 6) {
            theChars.removeLast(3)
            return theChars + "K"
            
        } else if (theChars.count > 6 && theChars.count <= 9) {
            theChars.removeLast(6)
            return theChars + "M"
            
        } else if (theChars.count > 9) {
            theChars.removeLast(9)
            return theChars + "B"
        }
        
        return theChars
    }
    
    public static func relativeDate(publishedAt: String) -> String {
        let theDate = DateInRegion(publishedAt)
        let relative = theDate!.toRelative(since: DateInRegion(), style: RelativeFormatter.twitterStyle(), locale: Locales.english)
        
        return relative
    }
}
