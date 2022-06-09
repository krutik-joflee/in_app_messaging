import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:in_app_messaging/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'In-App Messaging Demo',
      home: FirebaseInAppMessagingExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FirebaseInAppMessagingExample extends StatefulWidget {
  const FirebaseInAppMessagingExample({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _FirebaseInAppMessagingExampleState createState() =>
      _FirebaseInAppMessagingExampleState();
}

class _FirebaseInAppMessagingExampleState
    extends State<FirebaseInAppMessagingExample> {
  @override
  void initState() {
    super.initState();
    _getInstanceId();
  }

  void _getInstanceId() async {
    var token = await FirebaseMessaging.instance.getToken();
    FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
    // ignore: avoid_print
    print("Instance ID: ${token!}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('In-App Messaging Demo'),
      ),
      body: Center(
        child: OutlinedButton(
          child: const Text('In-App Messaging'),
          onPressed: () {
            FirebaseInAppMessaging.instance.triggerEvent("manual_trigger");
          },
        ),
      ),
    );
  }
}
