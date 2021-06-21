# Kvalifika SDK Flutter Sample

Use Kvalifika SDK to easily integrate into your Flutter app

Table of content:

- [Installation](#installation)
  - [iOS Specific Steps](#ios-specific-steps)
- [Initialize the SDK](#initialize-the-sdk)
- [Start Verification](#start-verification)
- [Handling Verifications](#handling-verifications)
  - [Callback Methods](#callback-methods)
  - [Error Codes](#error-codes)
- [UI Customizations](#ui-customizations)
  - [Appearance](#appearance)
  - [Language](#language)
- [ProGuard (Android)](#proguard-android)

&nbsp;

## Installation

Add dependency to pubspec.yaml file

```yaml
dependencies:
  kvalifika_sdk: ^0.7.0
```

&nbsp;

### iOS Specific Steps

If there is no Podfile in `ios` folder run `flutter build ios` in project folder's terminal

Add sources to Podfile and use minimum iOS version `11.0`

```podspec
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Kvalifika/kvalifika-cocoapods-specs.git'
source 'https://github.com/Kvalifika/zoom-cocoapods-specs.git'

platform :ios, '11.0'
```

Then navigate to `ios` folder and run `pod install`

`Note:` pod install might take long time

&nbsp;

Please add the following permissions to your app's Info.plist, so that the Kvalifika iOS SDK can access a user's camera to run a verification. You can do this in the property list view or by code. Right-click on Info.plist and select Open As -> Source Code. Add the lines below somewhere inside the <dict> </dict>

```plist
<!-- permission strings to be include in info.plist -->
<key>NSCameraUsageDescription</key>
<string>Please give us access to your camera, to complete the verification.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Please give us access to your photo library to verify you.</string>
```

&nbsp;

## Initialize the SDK

```dart
import 'package:kvalifika_sdk/kvalifika_sdk.dart';
```

After that you need to initialize SDK with **your appId**.

```dart
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kvalifika'),
        ),
        body: KvalifikaSdk(
          appId: "YOUR APP ID",
          locale: KvalifikaSdkLocale.EN,
          builder: (sdk) => Center(
            child: ElevatedButton(
              onPressed: () {
                sdk.startSession();
              },
              child: Text('Start Verification'),
            ),
          ),
        ),
      ),
    );
  }
}
```

&nbsp;

## Start Verification

Call `sdk.startSession()` on button press

```dart
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kvalifika'),
        ),
        body: KvalifikaSdk(
          appId: "YOUR APP ID",
          locale: KvalifikaSdkLocale.EN,
          builder: (sdk) => Center(
            child: ElevatedButton(
              onPressed: () {
                // Start session on button press
                sdk.startSession();
              },
              child: Text('Start Verification'),
            ),
          ),
        ),
      ),
    );
  }
}
```

&nbsp;

## Handling Verifications

It's useful to know if a user has completed the verification flow or canceled it. For this, you can implement the callback methods.

&nbsp;

### Callback Methods

| Method       | Description                                                                                |
| ------------ | ------------------------------------------------------------------------------------------ |
| onInitialize | This callback method is triggered when SDK initializes.                                    |
| onStart      | This callback method is triggered when user starts verification.                           |
| onFinish     | This callback method is triggered when user completes verification. Get session data here. |
| onError      | This callback method is triggered on error. [Error Codes](#error-codes).                   |

```dart
KvalifikaSdk(
  appId: "YOUR APP ID",
  onInitialize: () {

  },
  onStart: (sessionId) {

  },
  onFinish: (sessionId) {
    // Fetch session data from your backend server here
  },
  onError: (error, message) {
    if (error == KvalifikaSdkError.INVALID_APP_ID) {

    }

    if (error == KvalifikaSdkError.USER_CANCELLED) {

    }

    if (error == KvalifikaSdkError.TIMEOUT) {

    }

    if (error == KvalifikaSdkError.USER_CANCELLED) {

    }

    if (error == KvalifikaSdkError.SESSION_UNSUCCESSFUL) {

    }

    if (error == KvalifikaSdkError.ID_UNSUCCESSFUL) {

    }

    if (error == KvalifikaSdkError.CAMERA_PERMISSION_DENIED) {

    }

    if (error == KvalifikaSdkError.LANDSCAPE_MODE_NOT_ALLOWED) {

    }

    if (error == KvalifikaSdkError.REVERSE_PORTRAIT_NOT_ALLOWED) {

    }

    if (error == KvalifikaSdkError.FACE_IMAGES_UPLOAD_FAILED) {

    }

    if (error == KvalifikaSdkError.DOCUMENT_IMAGES_UPLOAD_FAILED) {

    }

    if (error == KvalifikaSdkError.COMPARE_IMAGES_FAILED) {

    }

    if (error == KvalifikaSdkError.UNKNOWN_INTERNAL_ERROR) {

    }
  },
  builder: (sdk) => Center(
    child: ElevatedButton(
      onPressed: () {
        sdk.startSession();
      },
      child: Text('Start Verification'),
    ),
  ),
)
```

&nbsp;

### Error Codes

| Error Code                    | Description                                                                              |
| ----------------------------- | ---------------------------------------------------------------------------------------- |
| INVALID_APP_ID                | Kvalifika App Id is incorrect                                                            |
| USER_CANCELLED                | User cancelled before completing verification.                                           |
| TIMEOUT                       | Cancelled due to inactivity.                                                             |
| SESSION_UNSUCCESSFUL          | The Session was not performed successfully.                                              |
| ID_UNSUCCESSFUL               | The ID Scan was not performed successfully and identity document data was not generated. |
| CAMERA_PERMISSION_DENIED      | Camera is required but access prevented by user settings.                                |
| LANDSCAPE_MODE_NOT_ALLOWED    | Verification cancelled because device is in landscape mode.                              |
| REVERSE_PORTRAIT_NOT_ALLOWED  | Verification cancelled because device is in reverse portrait mode.                       |
| FACE_IMAGES_UPLOAD_FAILED     | Could not upload face images. Internal request failed.                                   |
| DOCUMENT_IMAGES_UPLOAD_FAILED | Could not upload ID card or passport images. Internal request failed.                    |
| COMPARE_IMAGES_FAILED         | Could not compare images. Internal request failed.                                       |
| UNKNOWN_INTERNAL_ERROR        | Session failed because of an unhandled internal error. This error comes with message.    |

&nbsp;

## UI Customizations

### Appearance

You can customize logo and icons.
**Add image in Android drawable resources folder (res/drawable folder) and reference it with filename**

```dart
KvalifikaSdk(
  appId: "YOUR APP ID",
  logo: "logo",
  documentIcon: "document_icon",
  cancelIcon: "cancel_icon",
  activeFlashIcon: "active_flash_icon",
  inactiveFlashIcon: "inactive_flash_icon",
  builder: (sdk) => Center(
    child: ElevatedButton(
      onPressed: () {
        sdk.startSession();
      },
      child: Text('Start Verification'),
    ),
  ),
)
```

&nbsp;

### Language

You can set locale when initializing SDK
Supported locales are:

| Code | Language |
| ---- | -------- |
| EN   | English  |
| GE   | Georgian |

```dart
KvalifikaSdk(
  appId: "YOUR APP ID",
  locale: KvalifikaSdkLocale.EN
)
```

&nbsp;

### ProGuard (Android)

If you are using ProGuard in Android release build add following options to ProGuard file:

```
-keep class com.facetec.sdk.** { *; }
```
