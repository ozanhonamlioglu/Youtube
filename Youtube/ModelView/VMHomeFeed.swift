//
//  HomeFeed.swift
//  Youtube
//
//  Created by ozan honamlioglu on 5.05.2021.
//

import Foundation
import Alamofire

class VMHomeFeed: ObservableObject {
    @Published var list: MVideos?
    
    init() {
        getHomeList()
    }
    
    func getHomeList() {
        AF.request(YoutubeVideosList, encoding: JSONEncoding.default).validate().responseJSON { response in
            if (response.error != nil) { return }
            
            do {
                let videos = try JSONDecoder().decode(MVideos.self, from: response.data!)
                self.list = videos
                
            } catch {
                print("decoder error \(error.localizedDescription), \(error)")
            }
            
        }
        
    }
    
    func getImageUrl(thumbnails: MVideosItemsSnippetThumbNails) -> String {
        
        if let url = thumbnails.maxres?.url {
            return url
        }
        
        return thumbnails.high.url
    }
    
}
