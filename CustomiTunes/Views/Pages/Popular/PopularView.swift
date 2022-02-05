//
//  PopularView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 25.01.2022.
//

import SwiftUI

struct PopularView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                HScrollSpecialView(scroolKey: "firstScrool")
                HScroolWithTitleView(title: "Turkey Risers",contentKey: "turkeySongs")
                HScroolWithTitleView(title: "Global Hits",contentKey: "globalSongs")
                HScrollSpecialView(scroolKey: "secondScrool")
            }.navigationTitle("Popular Content")
                .padding(.bottom,10)
        }
    }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView()
    }
}
