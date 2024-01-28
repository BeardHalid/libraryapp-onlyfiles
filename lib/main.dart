import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:libraryapp/AppRoutes.dart';

Future<void> getDeviceToken() async {
  final token = await FirebaseMessaging.instance.getToken();
  if (token != null) {
    final tokenBox = await Hive.openBox<String>('tokenBox');
    tokenBox.add(token);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getDeviceToken();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
            color: Colors.orangeAccent,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))),
          )),
      routes: Routes.routes(),
      initialRoute: AppRoutes.splashScreen,
    );
  }
}
