//
//  SearchView.swift
//  Youtube
//
//  Created by ozan honamlioglu on 11.05.2021.
//

import SwiftUI

let searchPast = ["Test 1", "Test 2", "Test 3", "Test 4"]

struct SearchView: View {
    @State var searchText: String = ""
    @Binding var showSearch: Bool
    
    
    var body: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    SysImageButton(callback: {
                        showSearch = false
                    }, buttonImageName: "chevron.backward", activeButtonImageName: nil, active: nil, buttonLabel: nil)
                    
                    TextField("Search", text: $searchText)
                    
                    SysImageButton(callback: nil, buttonImageName: "mic", activeButtonImageName: nil, active: nil, buttonLabel: nil)
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                Divider()

                ScrollView {
                    VStack {
                        ForEach(searchPast, id: \.self) { item in
                            
                            Button(action: {
                                print("Do some bra")
                            }, label: {
                                EmptyView()
                            })
                            .buttonStyle(StateableButton(change: { state in
                                return HStack {
                                    Image(systemName: "clock.arrow.circlepath")
                                    Text(item)
                                    Spacer()
                                    Image(systemName: "arrow.up.backward")
                                }
                                .padding(.horizontal)
                                .frame(height: 50)
                                .background(state ? Color.black : Color.clear)
                                
                            }))
                            
                        }.foregroundColor(Color("generalForeground"))
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("primary").edgesIgnoringSafeArea(.all)
            
            SearchView(showSearch: .constant(true))
        }
        .preferredColorScheme(.dark)
    }
}
