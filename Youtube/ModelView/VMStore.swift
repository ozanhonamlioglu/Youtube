//
//  VMStore.swift
//  Youtube
//
//  Created by ozan honamlioglu on 8.05.2021.
//

import Foundation


class HomeDataStore {
    private var homeList: MVideos?
    
    func setHomeList(list: MVideos) {
        homeList = list
    }
    
    func getHomeList() -> MVideos? {
        return homeList
    }
}


// instantiates
var homeDataStore = HomeDataStore()
