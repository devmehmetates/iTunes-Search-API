//
//  LitteSongView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 26.01.2022.
//

import SwiftUI


@available(*, deprecated, message: "Moved to SmallTrackView")
struct LitteSongView: View {
    var song : PopularViewModel
    @State var selection = 0
    
    var body: some View {
        VStack(alignment:.leading,spacing: 4){
            NavigationLink {
                SongDetailView(songId: self.song.id)
            } label: {
                VStack(alignment:.leading,spacing:4){
                    AsyncImage(url: self.song.songImage) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(5)
                            .shadow(radius: 5, x: 0, y: 0)
                    } placeholder: {
                        ZStack{
                            Rectangle()
                                .frame(width: 100, height: 100, alignment: .center)
                                .foregroundColor(.primary.opacity(0.1))
                                .cornerRadius(5)
                            ProgressView()
                        }
                    }
                    VStack(alignment:.leading, spacing:4){
                        HStack(alignment:.top){
                            Text(self.song.songName)
                                .foregroundColor(.primary)
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                            Spacer()
                            ExplicitView(explicitState: song.trackExplicitness)
                        }
                    }.frame(width: 95,alignment: .topLeading)
                }
            }
            NavigationLink {
                ArtistDetailView(artistID: self.song.artistID, artistName: self.song.singerName)
            } label: {
                HStack{
                    Text(self.song.singerName)
                        .font(.caption2)
                        .lineLimit(1)
                    Spacer()
                }.frame(width: 95,alignment: .topLeading)
            }
        }
    }
}