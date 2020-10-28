//
//  UserOverlay.swift
//  widgetExtension
//
//  Created by Daniele Bernardi on 10/26/20.
//

import SwiftUI
import WidgetKit

struct UserOverlay : View {
  var user: User?
  
  @ViewBuilder
  var body: some View {
    if let user = user {
      if let profileImageUrl = URL(string: user.profileImageUrl),
         let imageData = try? Data(contentsOf: profileImageUrl),
         let uiImage = UIImage(data: imageData) {
        HStack(spacing: 10) {
          Image(uiImage: uiImage)
            .resizable()
            .frame(width: 32, height: 32, alignment: .center)
          
          Text(user.name)
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 10))
        }.background(Color.black.opacity(0.5)).padding()

      } else {
        HStack {
          Text(user.name)
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(5)
            .background(Color.black.opacity(0.5))
            .mask(Color.black)
        }.padding()

      }
    }
  }
}

struct UserOverlay_Previews: PreviewProvider {
    static var previews: some View {
      UserOverlay(user: MockData.user)
        .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
