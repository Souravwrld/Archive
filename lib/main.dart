import 'package:JazakAllah/application/utility/colors.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/counter_provider.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/gpt_provider.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/hadith_provider.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/link_provider.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/location_provider.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/note_provider.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/user_provider.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/wallpaper_provider.dart';
import 'package:JazakAllah/purchase/purchase_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'application/app.dart';
import 'data/services/locales/dependency_inj.dart';
import 'notification/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationServices().initNotification();
  tz.initializeTimeZones();

  //.env file define
  //await dotenv.load(fileName: "assets/.env");

  //Initialize Firebase
  try {
    await Firebase.initializeApp();
    print('Firebase initialize successfully');
  } catch (e) {
    print('Error initializing firebase: $e');
  }
  //Initialize one signal
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  // OneSignal.shared.setAppId("YOUR ONESIGNAL ID HERE");
  // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  //   print("Accepted permission: $accepted");
  // });

  Map<String, Map<String, String>> _languages = await LanguageDependency.init();
  //Initialize InApp Purchase
  //await PurchaseApi.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.colorPrimary),
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NoteProvider()),
    ChangeNotifierProvider(create: (context) => ZikirProvider()),
    ChangeNotifierProvider(create: (context) => LocationProvider()),
    ChangeNotifierProvider(create: (context) => HadithProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => GPTProvider()),
    ChangeNotifierProvider(create: (context) => WallPaperProvider()),
    ChangeNotifierProvider(create: (context) => LinkProvider()),
  ], child: JazakAllah(languages: _languages)));
}
