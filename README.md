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

**Important** Xcode project should be opened using cuadratic.xcworkspace in order to pick up the CocoaPod dependencies correctly.

####Notes
#####Stub Data
As this app is intended for Foursquare's venue users/managers, some of the  data to run/debug it is stub data as venue analytics and other information is only available to authorized venue managers.

If you are an authorized venue manager, you can switch on/off stub data in the AppDelegate file:

`var simulate: Bool = true`

To enable stub data, set the variable to true. To disable, set it to false.

#####Location Services
This app uses location services to automatically detect location and use it to perform venue searches. While debugging, you can set a custom location to simulate user's location. To do that, follow these steps:

- Go to Product menu > Scheme
- Select Edit Scheme
- Select Run/Debug in the left column options
- Select on Options menu
- Check "Allow Location Simulation" as set a Default Location from the dropdown

####Screenshots
<img src="https://github.com/ricardo-hdz/cuadratic/blob/master/readme_files/1.png" width="200">
<img src="https://github.com/ricardo-hdz/cuadratic/blob/master/readme_files/2.png" width="200">
<img src="https://github.com/ricardo-hdz/cuadratic/blob/master/readme_files/3.png" width="200">
<img src="https://github.com/ricardo-hdz/cuadratic/blob/master/readme_files/4.png" width="200">
