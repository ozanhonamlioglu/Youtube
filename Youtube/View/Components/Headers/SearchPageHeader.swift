//
//  SearchPageHeader.swift
//  Youtube
//
//  Created by ozan honamlioglu on 13.05.2021.
//

import SwiftUI

struct SearchPageHeader: View {
    @Binding var showSearchPage: Bool
    @Binding var showSearch: Bool
    var q: String
    
    var body: some View {
        HStack {
            SysImageButton(callback: {
                showSearchPage = false
            }, buttonImageName: "chevron.backward")
            
            Button(action: {
                showSearch = true
            }, label: {
                Text("\(q)")
                    .truncationMode(.tail)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 30, maxHeight: 30, alignment: .leading)
                    .foregroundColor(Color("generalForeground"))
            })
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
        SearchPageHeader(showSearchPage: .constant(false), showSearch: .constant(false), q: "Venom")
    }
}
