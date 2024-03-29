# Yelpy
Yelpy is an iOS app that allows user to browse restaurants nearby them from the [Yelp Fusion API](https://fusion.yelp.com).

## Table of Contents

- [Description](#description)
- [Requirements](#Requirements)
- [Demo](#demo)
- [Installation](#installation)
- [Testing](#testing)
- [Dependencies](#dependencies)
- [Contact](#contact)

## Description

Some of the main features include:

- User can login or create a new account, and stay logged in across restarts.
- User can view a tab bar with a home feed and chat tab
- Home Feed Tab
  - User can view restaurants nearby them using their location, and can search for restaurants using the search bar
  - User can tap a cell to see more details about a particular restaurant which also presents the restaurant's address in a MKMapView.
    - Users are able to take/upload a photo to a restaurant's map pin
  - User can load past restaurants infinitely using a UIRefreshControl
  - Presents an animations using Lottie and Skeleton View when restaurants are loading
- Chat Tab
  - User can chat with other app users using a Parse backend chat

## Requirements

- iOS 15.0 or later
- iPhone 6s or newer
- iPod touch 7th generation or newer

## Demo
### Current Progress Walkthrough

<img src="https://user-images.githubusercontent.com/74223402/218288833-f3b4e9a6-3a4b-4426-aae8-3d3838e4f939.gif" width=250><br>

## Installation

To install and set up the app on your own device, follow these steps:

### Prerequisites
- Xcode 11 or later
- CocoaPods (installation instructions can be found at https://cocoapods.org/)

### Cloning the repository

To clone the repository, open a terminal and enter the following command:
```
git clone https://github.com/kabirdhillon7/Yelpy
```

### Installing dependencies

To install the dependencies for the app, navigate to the directory where you cloned the repository and run the following command:
```
pod install
```
This will install all of the dependencies specified in the `Podfile`.

Open the `Yelpy.xcworkspace` file in Xcode. Make sure that the `Yelpy` scheme is selected, and then click the "Run" button to build and run the app.

### Configuration

Before you can use the app, you will need to set up your API keys. To do this, follow these steps:

1. Go to https://fusion.yelp.com and sign up for an API key.
2. In Xcode, open the `API.swift` file and replace `apikey` with the API key you received.

## Testing

## Dependencies

This app uses the following dependencies:

- [Alamofire](https://github.com/Alamofire/Alamofire) (MIT License)
- [Alamofire Image](https://github.com/Alamofire/AlamofireImage) (MIT License)
- [Core Location](https://developer.apple.com/documentation/corelocation)
- [MapKit](https://developer.apple.com/documentation/mapkit/)
- [Lottie](https://github.com/airbnb/lottie) (MIT License)
- [Parse](https://github.com/parse-community/Parse-SDK-iOS-OSX) (Parse Community Software License Agreement v1.0)
- [SkeletonView](https://github.com/Juanpe/SkeletonView) (MIT License)

## Contact

If you have any questions or feedback, you can reach me through the following channels:

- GitHub: [@kabirdhillon7](https://github.com/kabirdhillon7)
- LinkedIn: [Kabir Dhillon](https://www.linkedin.com/in/kabirdhillon/)
