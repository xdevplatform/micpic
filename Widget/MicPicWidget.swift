//
//  widget.swift
//  widget
//
//  Created by Daniele Bernardi on 10/24/20.
//

import WidgetKit
import SwiftUI

struct TweetEntry: TimelineEntry {
  var date: Date
  var media: Media?
  var tweet: Tweet?
  var user: User?
}

var searchResponse: TweetLookupResponse?

struct TweetProvider: TimelineProvider {
  func placeholder(in context: Context) -> TweetEntry {
    TweetEntry(date: Date())
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<TweetEntry>) -> Void) {
    let date = Date()
    
    requestTweets { response in
      guard let response = response,
            let tweets = response.data,
            tweets.count == 24 else {
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 15, to: date)!
        let entry = TweetEntry(date: date)
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
        
        completion(timeline)
        return
      }
            
      let entries: [TweetEntry] = tweets.enumerated().compactMap {
        (index, tweet) in
        guard let media = response.media(tweet: tweet)?.first,
           let user = response.user(of: tweet) else {
          return nil
        }
        
        let date = Calendar.current.date(byAdding: .hour, value: index, to: date)!
        
        return TweetEntry(date: date, media: media, tweet: tweet, user: user)
      }
      
      searchResponse = response
      let timeline = Timeline(entries: entries, policy: .atEnd)
      completion(timeline)
    }
  }
  
  typealias Entry = TweetEntry
  
  
  func requestTweets(completion: @escaping (TweetLookupResponse?) -> Void) {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.twitter.com"
    components.path = "/2/tweets/search/recent"
    components.queryItems = [
      URLQueryItem(name: "tweet.fields", value: "attachments"),
      URLQueryItem(name: "user.fields", value: "profile_image_url"),
      URLQueryItem(name: "media.fields", value: "url"),
      URLQueryItem(name: "expansions", value: "attachments.media_keys,author_id"),
      URLQueryItem(name: "query", value: "context:55.888105153038958593 has:images -is:retweet"),
      URLQueryItem(name: "max_results", value: "24")
    ]

    // Get the selected tweet
    let result = Twitter.request(url: components.url!, cached: false)
    switch result {
      case let .success(data):
        if let searchResult = data {
          completion(searchResult)
        } else {
          completion(nil)

        }
      case .failure(_):
      completion(nil)
    }
  }
 
  func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
    
    completion(TweetEntry(date: Date()))
  }
}

@main
struct MicPicWidget: Widget {
    let kind: String = "com.iamdaniele.🎤📸"

    var body: some WidgetConfiguration {
        StaticConfiguration(
          kind: kind,
          provider: TweetProvider()) { entry in
          TweetImageView(media: entry.media, tweet: entry.tweet, user: entry.user)
        }
        .configurationDisplayName("🎤📸")
        .description("Shows K-pop pictures from Twitter.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct widget_Previews: PreviewProvider {
    static var previews: some View {
      TweetImageView(media: MockData.media, tweet: MockData.tweet, user: MockData.user)
        .previewContext(WidgetPreviewContext(family: .systemLarge))
      TweetImageView()
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
