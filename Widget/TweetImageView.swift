//
//  TweetImageView.swift
//  widgetExtension
//
//  Created by Daniele Bernardi on 10/26/20.
//

import SwiftUI
import WidgetKit

struct TweetImageView: View {
  var media: Media?
  var tweet: Tweet?
  var user: User?
  
  @ViewBuilder
  var body: some View {
    if let media = media,
       let _ = media.url,
       let tweet = tweet,
       let user = user {
      VStack {}
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(TweetImage(media: media))
        .overlay(UserOverlay(user: user), alignment: .bottomLeading)
        .widgetURL(URL(string: "https://twitter.com/\(user.username)/status/\(tweet.id)"))
    } else {
      TweetImage(media: nil)
    }
  }
}

struct TweetImageView_Previews: PreviewProvider {
    static var previews: some View {
      TweetImageView(media: MockData.media, tweet: MockData.tweet, user: MockData.user)
        .previewContext(WidgetPreviewContext(family: .systemMedium))

    }
}
