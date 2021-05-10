//
//  LargeVideoPreview.swift
//  Youtube
//
//  Created by ozan honamlioglu on 5.05.2021.
//

import SwiftUI

struct LargeVideoPreview: View {
    @State private var loading: Bool? = true
    
    var url: String
    var title: String
    var channelName: String
    var viewCount: String?
    var publishedAt: String
        
    let width = UIScreen.main.bounds.width

    
    var body: some View {
        VStack {
            ZStack() {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                    ShowImage(withURL: url, loading: $loading)
                        .frame(width: width, alignment: .center)
                        .clipped()
                        .border(Color.gray, width: 0.5)
                    
                    Timer()
                }
                
                if(loading!) {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
            }.frame(height: loading! ? 100 : .none)
            
            HStack(alignment: .top) {
                SysImageButton(callback: nil, buttonImageName: "person.crop.circle")

                VStack(alignment: .leading) {
                    Text(title)
                        .font(.subheadline)
                    Text("\(channelName) • \(VMTabBarListFeed.getModifiedViewCountString(views: viewCount)) views • \(VMTabBarListFeed.relativeDate(publishedAt: publishedAt))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding(.horizontal, 10)
        }
    }
}

struct LargeVideoPreview_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init(UIColor(named: "background")!).edgesIgnoringSafeArea(.all)
            
            LargeVideoPreview(url: "https://i.ytimg.com/vi/L3A8kdCk_fM/maxresdefault.jpg", title: "Test Title", channelName: "Marvel Studio", viewCount: "1000", publishedAt: "2021-05-04T12:03:16Z")
        }
        .preferredColorScheme(.dark)
    }
}

struct Timer: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .cornerRadius(3)
            Text("10:20")
                .foregroundColor(.white)
                .font(.caption2)
        }
        .frame(width: 40, height: 20, alignment: .center)
        .padding(.all, 5)
    }
}
