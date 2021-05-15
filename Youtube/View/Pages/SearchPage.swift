//
//  SearchPage.swift
//  Youtube
//
//  Created by ozan honamlioglu on 13.05.2021.
//

import SwiftUI
import Combine

class SearchManager {
    var q = PassthroughSubject<String, Never>()
    var rawValue = ""
    
    func getCurrentVal() -> String {
        rawValue
    }
    
    func setQ(q: String) {
        rawValue = q
        self.q.send(q)
    }
}

var searchManager = SearchManager()

struct SearchPage: View {
    @Binding var showSearchPage: Bool
    @Binding var showSearch: Bool
    
    @State var loading = true
    @State var q = ""
    @ObservedObject var searchList = VMSearch()
    
    var body: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            VStack {
                SearchPageHeader(showSearchPage: $showSearchPage, showSearch: $showSearch, q: q)
                    .padding(.vertical, 5)
                Spacer()
                
                if (loading) {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                    
                } else {
                    VStack {
                        ForEach(searchList.list!.items, id: \.self) { item in
                            LargeVideoPreview(
                                url: searchList.getImageUrl(thumbnails: item.snippet.thumbnails),
                                title: item.snippet.title,
                                channelName: item.snippet.channelTitle,
                                viewCount: item.statistics?.viewCount,
                                publishedAt: item.snippet.publishedAt
                            )
                        }
                    }.modifier(TrackableScrollView())
                }
            }
        }
        .navigationBarHidden(true)
        .onReceive(tabbarManager.tabChange, perform: { tab in
            showSearchPage = false
        })
        .onReceive(searchList.$list, perform: { list in
            if list != nil {
                loading = false
            }
        })
        .onReceive(searchManager.q, perform: { val in
            self.q = val
            searchList.makeSearch(for: val)
        })
        .onAppear(perform: {
            let managerQuery = searchManager.getCurrentVal()
            if (!managerQuery.isEmpty) {
                self.q = managerQuery
                searchList.makeSearch(for: managerQuery)
            }
        })
        .onDisappear(perform: {
            searchManager.setQ(q: "")
        })
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage(showSearchPage: .constant(false), showSearch: .constant(false))
            .preferredColorScheme(.dark)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
