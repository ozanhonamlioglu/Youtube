//
//  SearchPageHeader.swift
//  Youtube
//
//  Created by ozan honamlioglu on 13.05.2021.
//

import SwiftUI

struct SearchPageHeader: View {
    @Binding var showSearchPage: Bool
    
    var body: some View {
        HStack {
            SysImageButton(callback: {
                showSearchPage = false
            }, buttonImageName: "chevron.backward")
            
            Spacer()
            
            HStack(spacing: 15) {
                SysImageButton(callback: nil, buttonImageName: "laptopcomputer.and.iphone")
                SysImageButton(callback: nil, buttonImageName: "bell")
                SysImageButton(callback: nil, buttonImageName: "person.crop.circle")
            }
        }
        .padding(.horizontal)
    }
}

struct SearchPageHeader_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageHeader(showSearchPage: .constant(false))
    }
}
