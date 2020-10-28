//
//  Provider.swift
//  WidgetExtension
//
//  Created by Daniele Bernardi on 10/28/20.
//

import WidgetKit

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

      searchResponse = response

      let entries: [TweetEntry] = tweets.enumerated().compactMap { (index, tweet) in
        let date = Calendar.current.date(byAdding: .hour, value: index, to: date)!

        if let media = response.media(tweet: tweet)?.first,
           let user = response.user(of: tweet) {
          return TweetEntry(
            date: date,
            media: media,
            tweet: tweet,
            user: user)
        }
        return nil
      }

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
      URLQueryItem(name: "query", value: "context:66.852263859209478144 has:images -is:retweet"),
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
    let date = Calendar.current.date(bySetting: .hour, value: 0, of: Date())!
    let entry = TweetEntry(date: date,
                           media: MockData.media,
                           tweet: MockData.tweet,
                           user: MockData.user)
    completion(entry)
  }
}
