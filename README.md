# Uber

A clone of the well-known taxi service or private drivers - Uber. An adaptive interface has been created via SwiftUI using MVVM, a dark theme is supported. Using MapKit, the user sees his location and can get a route to the selected point. User authentication has been created - login, registration. Data about users and trips are stored in Firebase. A passenger can see drivers nearby and request a ride from them on three different types - UberX, UberBlack, UberXL. The function of saving two favorite places has also been added. This is not a complete list of all the possibilities

## Preview

<div style='display: flex'>
    <img src='../service/imgs/main.png' height=350>
    <img src='../service/imgs/left-screen-dark.png' height=350>
    <img src='../service/imgs/settings.png' height=350>
    <img src='../service/imgs/ride_request.png' height=345>
</div>

## Features
### User Authentication
* **Login/Sign Up/Sign Out functionality:** Secure user access to the application.

### User Types
* **Passengers and Drivers:** Differentiated user experience for both passengers and drivers.

### Map Integration
* **Display Nearby Drivers:** Locate drivers around you on a map.
* **Request Rides:** Passengers can request rides from nearby drivers.
* **Dynamic Map View:** The map follows the user's location.
* **Display Current User Location:** Always know where you are.

### User Experience
* **Two Separate User Flows:** Unique experience for passengers and drivers.
* **Save Preferred User Locations:** For convenient reuse.
* **Search for Nearby Locations with Auto-Complete:** Similar to Apple Maps.
* **Get Directions:** Navigate to your chosen destination.
* **Side Menu Feature:** Easy access to various functionalities.
* **Dark Mode Support:** Comfortable usage at any time of the day.

### Ride Management
* **Different Ride Types:** Choose from UberX, UberBlack, UberXL, etc.
* **Custom Pricing Model:** Flexibility in choosing ride costs.
* **Cancel a Trip:** Ability to cancel a ride at any time.
* **Drivers can Receive and Accept Ride Requests:** Quick and convenient connection with passengers.

### Profile and Settings
* **User Profile/Settings Page:** Customize your profile as you like.

### Backend
* **Custom Built Backend Database with Cloud Firestore:** Reliable and scalable data storage.

---

## Requirements

 - iOS 16.0 or later
 - Xcode 14.0 or later

## Contribution

If you find any issues or want to contribute to the project, please create a Pull Request or make an Issue in this repository.

## Installation

1. Clone the Tic Tac Toe repository:
   ```shell
   git@github.com:KeoFoxy/Uber.git
   ```
2. Open the `Uber.xcodeproj` project in Xcode.
3. Build and run the project on a simulator or a real device.