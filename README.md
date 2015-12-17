#Cuadratica

Cuadratica is an iOS app for Foursquare venue managers to search, bookmark and manage venues and view venue analytics.

The app uses [Foursquare API](https://developer.foursquare.com/) to search for venues given a keyword and/or location and to display managed venues based on the entitlements of the logged in user.

Venue statistics provide total checkins, social media impact, demographics and user and hour breakdowns.

####Dependencies
Cuadratica uses the following dependencies:

- [Google Places API](https://developers.google.com/places/ios-api/start): to provide autocomplete suggestions for places and location in search.
- [Font Awesome](https://github.com/thii/FontAwesome.swift): to display icons in the app.
- [iOS-charts](https://github.com/danielgindi/ios-charts): to display statistics breakdown.

####Installation and usage
The app uses CocoaPods to install some of the dependencies, you need to have CocoaPods installed before running the app.

If you need to install, follow instructions [here](https://guides.cocoapods.org/using/getting-started.html)

```
git clone https://github.com/ricardo-hdz/cuadratic.git
pod install
Open project: cuadratic.xcworkspace
```
Run it!

**Important** Xcode project should be open using cuadratic.xcworkspace in order to pick up the CocoaPod dependencies correctly.
