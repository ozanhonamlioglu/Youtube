//
//  HomeFeed.swift
//  Youtube
//
//  Created by ozan honamlioglu on 5.05.2021.
//

import Foundation
import Alamofire
import SwiftDate

class VMHomeFeed: ObservableObject {
    @Published var list: MVideos?
    
    init() {
        getHomeList()
    }
    
    func getHomeList() {
        if (homeDataStore.getHomeList() == nil) {
            AF.request(YoutubeVideosList, encoding: JSONEncoding.default).validate().responseJSON { response in
                if (response.error != nil) { return }
                
                do {
                    let videos = try JSONDecoder().decode(MVideos.self, from: response.data!)
                    self.list = videos
                    homeDataStore.setHomeList(list: videos)
                    
                } catch {
                    print("decoder error \(error.localizedDescription), \(error)")
                }
                
            }
        } else {
            list = homeDataStore.getHomeList()
        }
    }
    
    func refreshHome() {
        print("Refresh occured")
    }
    
    func getImageUrl(thumbnails: MVideosItemsSnippetThumbNails) -> String {
        
        if let url = thumbnails.maxres?.url {
            return url
        }
        
        return thumbnails.high.url
    }
    
    public static func getModifiedViewCountString(views: String) -> String {
        
        // 999.999 -> (999K) 6 chars
        // 999.999.999 -> (999M) 9 chars
        // x.999.999.999 -> (xB) >9 chars
        var theChars = views
        
        if(views.count >= 4 && views.count <= 6) {
            theChars.removeLast(3)
            return theChars + "K"
            
        } else if (views.count > 6 && views.count <= 9) {
            theChars.removeLast(6)
            return theChars + "M"
            
        } else if (views.count > 9) {
            theChars.removeLast(9)
            return theChars + "B"
        }
        
        return views
    }
    
    public static func relativeDate(publishedAt: String) -> String {
        let theDate = DateInRegion(publishedAt)
        let relative = theDate!.toRelative(since: DateInRegion(), style: RelativeFormatter.twitterStyle(), locale: Locales.english)
        
        return relative
    }
}
