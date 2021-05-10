//
//  VMStore.swift
//  Youtube
//
//  Created by ozan honamlioglu on 8.05.2021.
//

import Foundation

protocol DataStoreProtocol {
    func getList() -> MVideos?
    func setList(list: MVideos) -> Void
}

class HomeDataStore: DataStoreProtocol {
    private var homeList: MVideos?
    
    func setList(list: MVideos) {
        homeList = list
    }
    
    func getList() -> MVideos? {
        return homeList
    }
}

class TrendingDataStore: DataStoreProtocol {
    private var trendingList: MVideos?
    
    func setList(list: MVideos) {
        trendingList = list
    }
    
    func getList() -> MVideos? {
        return trendingList
    }
}

class SubscriptionDataStore: DataStoreProtocol {
    private var subscriptionList: MVideos?
    
    func setList(list: MVideos) {
        subscriptionList = list
    }
    
    func getList() -> MVideos? {
        return subscriptionList
    }
}

class LibraryDataStore: DataStoreProtocol {
    private var libraryList: MVideos?
    
    func setList(list: MVideos) {
        libraryList = list
    }
    
    func getList() -> MVideos? {
        return libraryList
    }
}

// instantiates
var homeDataStore = HomeDataStore()
var trendingDataStore = TrendingDataStore()
var subscriptionDataStore = SubscriptionDataStore()
var libraryDataStore = LibraryDataStore()
