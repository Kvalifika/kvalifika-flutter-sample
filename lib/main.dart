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
              print("invalid app id, please provide app id");
            }
          },
          locale: KvalifikaSdkLocale.EN,
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
