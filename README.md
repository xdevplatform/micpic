# 🎤📸 MicPic

Easily stan your favorite K-pop stars from the comfort of your home screen via an iOS 14 widget.

This widget connects to Twitter's [Recent Search](https://developer.twitter.com/en/docs/twitter-api/tweets/search/introduction) to get the most recent K-pop related images. Images are detected to be about K-pop through [Tweet annotations](https://developer.twitter.com/en/docs/twitter-api/annotations).

## How does it work?

1. Every day, the widget asks the Twitter API for 24 K-pop related Tweets.
2. The timeline provider creates a `Timeline` with those Tweets (one per hour)
3. WidgetKit will try to load a new image every hour or so (depending on how much screen time your widget gets, your battery status, etc.)
4. The app requests new Tweets at the end of the timeline.

If for any reason the app fails to get a response from the Twitter API, the widget should retry every 15 minutes until it succeeds.

## How do I build this app?

Start up your latest Xcode! Xcode 12 (targeting the iOS 14 SDK) should work. Before you start, you will need:

- A valid Twitter developer account. Don't have one? Apply on [Twitter Developer](https://developer.twitter.com/apply)
- Access to v2. If you haven't done so, create a new [Project](https://developer.twitter.com/en/docs/projects/overview). Make sure you have an app connected to the project.
- A [Bearer token](https://developer.twitter.com/en/docs/authentication/oauth-2-0/bearer-tokens) for this project. You can generate a Bearer token for your app under "Keys and tokens" in Developer Portal.

Once you have your Bearer token, locate the `Info.plist` under the **Widget** group in Xcode. 

## What can I do with this app?

Have fun! You can expand the widget by supporting multiple contexts, or you can try with different Tweet annotations. Change the `context` to `65.852262932607926273` for pets!

## What if I build something cool with this sample project? What if I need help?

Let us know! If you have issues, or if you end up building something cool with this project, come see us on the [Twitter Community](https://twittercommunity.com) forums!
