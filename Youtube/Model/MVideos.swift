//
//  PlayListItem.swift
//  Youtube
//
//  Created by ozan honamlioglu on 5.05.2021.
//

import Foundation

struct MVideos: Decodable, Hashable {
    var kind: String
    var etag: String
    var nextPageToken: String
    var prevPageToken: String?
    var pageInfo: MVideosPageInfo
    var items: [MVideosItems]
}

struct MVideosPageInfo: Decodable, Hashable {
    var totalResults: Int
    var resultsPerPage: Int
}

struct MVideosItems: Decodable, Hashable {
    var kind: String
    var etag: String
    // var id: String
    var snippet: MVideosItemsSnippet
    //var contentDetails: MVideosItemsContentDetail
    var statistics: MVideosItemsStatistics?
}

struct MVideosItemsStatistics: Decodable, Hashable {
    var viewCount: String?
    var likeCount: String?
    var dislikeCount: String?
    var favoriteCount: String?
    var commentCount: String?
}

struct MVideosItemsContentDetail: Decodable, Hashable {
    var duration: String
    var dimension: String
    var definition: String
    var caption: Bool
    var licensedContent: Bool
}

struct MVideosItemsSnippet: Decodable, Hashable {
    var publishedAt: String
    var channelId: String
    var title: String
    var channelTitle: String
    var description: String
    var thumbnails: MVideosItemsSnippetThumbNails
}

struct MVideosItemsSnippetThumbNails: Decodable, Hashable {
    var `default`: MVideosItemsSnippetThumbNailValue
    var medium: MVideosItemsSnippetThumbNailValue
    var high: MVideosItemsSnippetThumbNailValue
    var standard: MVideosItemsSnippetThumbNailValue?
    var maxres: MVideosItemsSnippetThumbNailValue?
}

struct MVideosItemsSnippetThumbNailValue: Decodable, Hashable {
    var url: String
    var width: Int
    var height: Int
}
