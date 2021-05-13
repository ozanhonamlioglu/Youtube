//
//  SearchPage.swift
//  Youtube
//
//  Created by ozan honamlioglu on 13.05.2021.
//

import SwiftUI

struct SearchPage: View {
    @Binding var showSearchPage: Bool
    
    var body: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            VStack {
                SearchPageHeader(showSearchPage: $showSearchPage)
                    .padding(.vertical, 5)
                Trending()
            }
        }
        .navigationBarHidden(true)
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage(showSearchPage: .constant(false))
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
