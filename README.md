
# FireToken

FireToken is an app designed to make Firebase push notification integration simple and efficient. With the FireToken playground and its easy-to-follow guidelines, you can quickly generate access tokens and seamlessly integrate push notifications into your app, making it much easier to manage and test notifications.

## Table of Contents
- [Features](#features)
- [Getting Started](#getting-started)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Dynamic Environment Variables](#dynamic-environment-variables)
- [Generating Access Tokens](#generating-access-tokens)
- [Testing Notifications](#testing-notifications)
- [Contributing](#contributing)
- [License](#license)

## Features
- Simple integration with Firebase Cloud Messaging (FCM)
- Token generation for secure notifications
- User-friendly interface for testing and managing notifications
- Supports both Android and iOS platforms

## Getting Started

This project is a starting point for a Flutter application. A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/trulykasodiya-hub/firetoken-app.git
   ```
2. Navigate to the project directory:
   ```
   cd firetoken-app
   ```
3. Install the required dependencies:
   ```
   flutter pub get
   ```

## Usage

To run the app, you can set your Firebase environment variables dynamically using the following command:

### Dynamic Environment Variables

To set the Firebase configuration values dynamically, use the following command structure:

```
flutter run --dart-define=ANDROID_API_KEY='your_api_key'
--dart-define=IOS_API_KEY='your_ios_api_key'
--dart-define=APP_ID='your_app_id'
--dart-define=MESSAGING_SENDER_ID='your_messaging_sender_id'
--dart-define=PROJECT_ID='your_project_id'
--dart-define=STORAGE_BUCKET='your_storage_bucket'
--dart-define=IOS_BUNDLE_ID='your_ios_bundle_id'
```

Replace the placeholders (`your_api_key`, `your_app_id`, etc.) with your actual Firebase project values. This will allow your app to use these values at runtime without hardcoding them into your codebase.

### Example Command
Here is an example of how to run the app with dynamic values:

```
flutter run --dart-define=ANDROID_API_KEY='AIzaSyD-EXAMPLE'
--dart-define=IOS_API_KEY='AIzaSyD-EXAMPLE'
--dart-define=APP_ID='1:1234567890:android:abcdef123456'
--dart-define=MESSAGING_SENDER_ID='1234567890'
--dart-define=PROJECT_ID='your_project_id'
--dart-define=STORAGE_BUCKET='your_storage_bucket'
--dart-define=IOS_BUNDLE_ID='com.example.yourapp'
```

Ensure that your Firebase project is set up correctly and that you have added your `google-services.json` for Android and `GoogleService-Info.plist` for iOS.

## Configuration

### Firebase Setup

1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Add your app to the project:
   - For Android: Download `google-services.json` and place it in the `android/app` directory.
   - For iOS: Download `GoogleService-Info.plist` and place it in the `ios/Runner` directory.
3. Enable Cloud Messaging in your Firebase project settings.

## Generating Access Tokens

To generate access tokens for FCM:

1. Navigate to the FireToken playground in the app.
2. Follow the on-screen instructions to input your Firebase project details.
3. Click on "Generate Token" to receive your access token.

## Testing Notifications

1. Use the generated token to send test notifications via the Firebase Console or your backend server.
2. In the app, you can view received notifications and test various payload formats.

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Make your changes and commit them (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
