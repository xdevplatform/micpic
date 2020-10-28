//
//  TweetImage.swift
//  widgetExtension
//
//  Created by Daniele Bernardi on 10/26/20.
//

import SwiftUI
import WidgetKit

struct TweetImage: View {

  let media: Media?
  
  @ViewBuilder
  var body: some View {
    if let mediaURLString = media?.url,
       let mediaURL = URL(string: mediaURLString),
       let imageData = try? Data(contentsOf: mediaURL),
       let image = UIImage(data: imageData) {
      Image(uiImage: image)
        .resizable()
        .scaledToFill()
    } else {
      VStack {
        Text("🤳").font(.largeTitle)
        Text("Loading pictures…").font(.caption)
      }
    }
    
  }
}

struct TweetImage_Previews: PreviewProvider {
    static var previews: some View {
      TweetImage(media: MockData.media)
        .previewContext(WidgetPreviewContext(family: .systemLarge))
      TweetImage(media: nil)
        .previewContext(WidgetPreviewContext(family: .systemMedium))

    }
}
