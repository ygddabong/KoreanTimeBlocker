# KoreanTimeBlocker

An iOS alarm app that works backwards from when you need to arrive: pick a destination and arrival time, add your preparation steps, and it tells you when to start getting ready and when to leave.

Written in 2020 while learning iOS development; repo cleaned up in 2026.

<p>
  <img width="180" src="https://user-images.githubusercontent.com/39237004/81466300-87459000-920b-11ea-9f27-7ecb99311733.png">
  <img width="180" src="https://user-images.githubusercontent.com/39237004/81466302-890f5380-920b-11ea-8d61-42634af45d45.png">
  <img width="180" src="https://user-images.githubusercontent.com/39237004/81466301-8876bd00-920b-11ea-933c-4de1b0ba6533.png">
  <img width="180" src="https://user-images.githubusercontent.com/39237004/81466298-857bcc80-920b-11ea-9aa3-bbbde6ff63a0.png">
</p>
<p>
  <img width="180" src="https://user-images.githubusercontent.com/39237004/81466308-8dd40780-920b-11ea-9ed5-e1d0c224cf04.png">
  <img width="180" src="https://user-images.githubusercontent.com/39237004/81466306-8c0a4400-920b-11ea-9f44-dd16d1bc4be5.png">
  <img width="180" src="https://user-images.githubusercontent.com/39237004/81466307-8ca2da80-920b-11ea-936d-1ffa7fa907fe.png">
</p>

## Features

- Destination search with Google Places autocomplete, shown on Google Maps from your current location
- Arrival-time setting
- A list of preparation steps (e.g. shower, breakfast) with durations
- Countdown screen showing when to start preparing and when to leave

## Tech stack

- Swift 5, UIKit, Storyboard
- Google Maps SDK and Google Places SDK for iOS (via CocoaPods)
- Core Location

## Running

1. Install [CocoaPods](https://cocoapods.org) and run:

   ```bash
   pod install
   ```

2. Get a Google Maps Platform API key with the **Maps SDK for iOS** and **Places API** enabled.
3. Provide the key through the `GMS_API_KEY` build setting — it is read from `Info.plist` (`GMSApiKey = $(GMS_API_KEY)`) at launch:
   - In Xcode: target → Build Settings → **+** → Add User-Defined Setting → `GMS_API_KEY`. Keep this change local (don't commit it).
   - Or from the command line: `xcodebuild … GMS_API_KEY=your-key`
4. Open **`KoreanTimeBlocker.xcworkspace`** in Xcode and run.

The pod versions are pinned in `Podfile.lock` to the 2020 releases the code was written against.

## 2026 update

- Removed the committed `Pods/` directory — `pod install` recreates it from `Podfile.lock`
- The Google Maps API key is now read from a build setting instead of a placeholder string in `AppDelegate.swift`
- `Podfile`: set the iOS platform and added a `post_install` hook so recent Xcode versions can build the old pods
- Removed per-user Xcode files; added `.gitignore`; rewrote README
