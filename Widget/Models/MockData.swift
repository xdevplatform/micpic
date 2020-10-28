//
//  MockData.swift
//  widgetExtension
//
//  Created by Daniele Bernardi on 10/26/20.
//

import Foundation

struct MockData {
  static let tweet = Tweet(
    attachments: Attachments(mediaKeys: ["1"]),
    authorId: "1",
    id: "1",
    text: "Preview")
  
  static let user = User(
    id: "1",
    name: "Twitter Dev",
    username: "TwitterDev",
    profileImageUrl: "https://pbs.twimg.com/profile_images/1283786620521652229/lEODkLTh_normal.jpg")
  
  static let media = Media(
    mediaKey: "1",
    type: .photo,
    url: "https://thiscatdoesnotexist.com")
  
  static let includes = Includes(
    media: [media],
    users: [user])

  static let searchResponse = TweetLookupResponse(
      data: Array(repeating: tweet, count: 24),
      includes: includes)
}
