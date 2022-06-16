//
//  SearchView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 31.01.2022.
//

import SwiftUI

struct SearchView: View {
    @State private var searchKey = ""
    @ObservedObject private var pageClient = SearchViewClient()
    let recommendedList  = [
        "LOCAL_SEARCHTIPS_1",
        "LOCAL_SEARCHTIPS_2",
        "LOCAL_SEARCHTIPS_3",
        "LOCAL_SEARCHTIPS_4",
        "LOCAL_SEARCHTIPS_5",
        "LOCAL_SEARCHTIPS_6",
        "LOCAL_SEARCHTIPS_7",
        "LOCAL_SEARCHTIPS_8",
    ]
    var body: some View {
        NavigationView{
            List{
                if self.pageClient.searchResult.isEmpty && !searchKey.isEmpty{
                    ProgressView()
                }else{
                    ForEach(self.pageClient.searchResult) { result in
                        SearchListItemView(listSong: result)
                    }
                }
            }.searchable(text: $searchKey){
                ForEach(self.recommendedList, id: \.self){ recommed in
                    Button {
                        self.searchKey = NSLocalizedString(recommed, comment: "searchKeys")
                        Task{
                            self.pageClient.searchResult.removeAll()
                        }
                        self.pageClient.getSearchResult(for: self.searchKey)
                    } label: {
                        Text(LocalizedStringKey(recommed))
                            .foregroundColor(.accentColor)
                    }
                }
            }.navigationTitle("LOCAL_SEARCH")
            
//            ScrollView{
//                SearchBarView(searchKey: self.$searchKey,pageClient: self.pageClient)
//                if self.pageClient.searchResult.isEmpty{
//                    ForEach(self.recommendedList, id: \.self){ recommed in
//                        Button {
//                            self.searchKey = NSLocalizedString(recommed, comment: "searchKeys")
//                            Task{
//                                self.pageClient.searchResult.removeAll()
//                            }
//                            self.pageClient.getSearchResult(for: self.searchKey)
//                        } label: {
//                            Text(LocalizedStringKey(recommed))
//                                .foregroundColor(Color("ThemeColor"))
//                        }
//                    }
//                }
//                if !self.pageClient.searchResult.isEmpty{
//                    ForEach(self.pageClient.searchResult){ song in
//                        SearchListItemView(listSong: song)
//                    }
//                }
//            }
//                .padding(.bottom,10)
        }.onChange(of: searchKey, perform: { newValue in
            if newValue.isEmpty{
                self.pageClient.searchResult.removeAll()
            }else{
                Task{
                    self.pageClient.getSearchResult(for: newValue)
                }
            }
        })
        .onSubmit {
            Task{
                self.pageClient.getSearchResult(for: self.searchKey)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}