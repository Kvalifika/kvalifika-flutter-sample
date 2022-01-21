import 'package:flutter/material.dart';
import 'package:kvalifika_sdk/kvalifika_sdk.dart';

void main() {
  runApp(MyApp());
}

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
          onInitialize: (context, sdk) {
            sdk.startSession();
          },
          onStart: (context, sessionId) {},
          onFinish: (context, sessionId) {},
          onError: (context, error, message) {
            if (error == KvalifikaSdkError.INVALID_APP_ID) {
              Text("Invalid App ID, please provide app id");
            } else if (error == KvalifikaSdkError.USER_CANCELLED) {
              Text("User cancelled");
            } else if (error == KvalifikaSdkError.TIMEOUT) {
              Text("Timeout");
            } else if (error == KvalifikaSdkError.SESSION_UNSUCCESSFUL) {
              Text("Session failed");
            } else if (error == KvalifikaSdkError.ID_UNSUCCESSFUL) {
              Text("ID scan failed");
            } else if (error == KvalifikaSdkError.CAMERA_PERMISSION_DENIED) {
              Text("Camera permission denied");
            } else if (error == KvalifikaSdkError.LANDSCAPE_MODE_NOT_ALLOWED) {
              Text("Landscape mode is not allowed");
            } else if (error == KvalifikaSdkError.REVERSE_PORTRAIT_NOT_ALLOWED) {
              Text("Reverse portrait is not allowed");
            } else if (error == KvalifikaSdkError.FACE_IMAGES_UPLOAD_FAILED) {
              Text("Could not upload face images");
            } else if (error == KvalifikaSdkError.DOCUMENT_IMAGES_UPLOAD_FAILED) {
              Text("Could not upload Id card or passport images");
            } else if (error == KvalifikaSdkError.NO_MORE_ATTEMPTS) {
              Text("No more attempt left");
            } else if (error == KvalifikaSdkError.UNKNOWN_INTERNAL_ERROR) {
              Text("Unknown error happened: $message");
            }
          },
          locale: KvalifikaSdkLocale.GE,
          development: true,
          builder: (context, sdk) => Center(
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
