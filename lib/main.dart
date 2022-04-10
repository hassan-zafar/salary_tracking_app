import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:salary_tracking_app/main_screen.dart';
import 'package:salary_tracking_app/provider/auto_play_provider.dart';
import 'package:salary_tracking_app/provider/background_play_provider.dart';
import 'package:salary_tracking_app/provider/dark_theme_provider.dart';
import 'package:salary_tracking_app/provider/favs_provider.dart';
import 'package:salary_tracking_app/provider/notification_preferences.dart';
import 'package:salary_tracking_app/provider/products.dart';
import 'package:salary_tracking_app/screens/auth/forget_password.dart';
import 'package:salary_tracking_app/screens/auth/login.dart';
import 'package:salary_tracking_app/screens/auth/sign_up.dart';
import 'package:salary_tracking_app/services/user_state.dart';
import 'package:salary_tracking_app/widgets/bottom_bar.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_importance_channel",
  "High Importance Notifications",
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Wage Me',
    options: const FirebaseOptions(
        apiKey: 'AIzaSyC9mvlxZ1gXJ0IGMmVqSWG1zLnkbiiDMlw',
        appId: '1:165461244282:web:2b6de2f5801e842af5fec3',
        messagingSenderId: '165461244282',
        projectId: 'wageme-29f75',
        authDomain: 'wageme-29f75.firebaseapp.com',
        storageBucket: "wageme-29f75.appspot.com",
        measurementId: "G-LGZP9WMLVH"),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  AutoPlayProvider autoPlayChangeProvider = AutoPlayProvider();
  NotificationSetProvider notificationSetProvider = NotificationSetProvider();
  BackgroundPlayProvider backgroundPlayProvider = BackgroundPlayProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              home: const Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
              theme: ThemeData(
                  primaryColor: Colors.yellow, accentColor: Colors.orange),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return themeChangeProvider;
              }),
              ChangeNotifierProvider(create: (_) {
                return autoPlayChangeProvider;
              }),
              ChangeNotifierProvider(create: (_) {
                return notificationSetProvider;
              }),
              ChangeNotifierProvider(create: (_) {
                return backgroundPlayProvider;
              }),
              ChangeNotifierProvider(
                create: (_) => Products(),
              ),
              ChangeNotifierProvider(
                create: (_) => FavsProvider(),
              ),
            ],
            child: Consumer<DarkThemeProvider>(
              builder: (context, themeChangeProvider, ch) {
                return MaterialApp(
                  title: 'Wage Me',
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  home: UserState(),
                  routes: {
                    MainScreens.routeName: (ctx) => MainScreens(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                    ForgetPassword.routeName: (ctx) => ForgetPassword(),
                  },
                );
              },
            ),
          );
        });
  }
}
