//
//  VMSearch.swift
//  Youtube
//
//  Created by ozan honamlioglu on 15.05.2021.
//

import Foundation
import Alamofire

class VMSearch: ObservableObject {
    @Published var list: MVideos?
    
    func makeSearch(for q: String) {
        let mQ = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=\(q)&key=AIzaSyAa8yy0GdcGPHdtD083HiGGx_S0vMPScDM"
        AF.request(mQ, encoding: JSONEncoding.default).validate().responseJSON { response in
            if response.error != nil { return }
            
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
        
        return thumbnails.medium.url
    }
    
}
