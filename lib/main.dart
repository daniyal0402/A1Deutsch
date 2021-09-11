import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vocabulary_client/UI/screens/AboutUs.dart';
import 'package:vocabulary_client/UI/screens/ContactUs.dart';

// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:vocabulary_client/UI/screens/HomepageParent.dart';
import 'package:vocabulary_client/UI/screens/Splash.dart';
import 'package:easy_localization/easy_localization.dart';
// Future<void> backgroundHandler(RemoteMessage message) async {
//   print(message.data.toString());
//   print(message.notification.title);
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // await FlutterDownloader.initialize(
  //     debug: true // optional: set false to disable printing logs to console
  //     );

  runApp(EasyLocalization(
    path: 'assets/locales',
    supportedLocales: [Locale('en', 'EN'), Locale('de', 'DE')],
    fallbackLocale: Locale('en', 'EN'),
    startLocale: Locale('de', 'DE'),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocab App',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/ContactUs': (context) => ContactUsPage(),
        '/AboutUs': (context) => AboutUs(),
      },
    );
  }
}
