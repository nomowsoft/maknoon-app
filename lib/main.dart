import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maknoon/controller/data_sync_controller.dart';
import 'package:maknoon/controller/home_controller.dart';
import 'package:maknoon/firebase_options.dart';
import 'package:maknoon/model/core/shared/constants.dart';
import 'package:maknoon/model/localization/translation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:maknoon/model/services/data_sync_service.dart';
import 'package:maknoon/model/services/user_service.dart';
import 'package:maknoon/ui/views/data_initialization/data_initialization.dart';
import 'package:maknoon/ui/views/home/home.dart';
import 'package:maknoon/ui/views/user/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maknoon/model/theme/theme_dark.dart';
import 'package:maknoon/model/core/shared/globals/size_config.dart';
import 'package:maknoon/model/theme/theme_light.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'model/core/user/auth_model.dart';
//import 'package:background_fetch/background_fetch.dart';
import 'package:workmanager/workmanager.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Translation translation = Translation();
  await translation.fetchLocale();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'AllUsers', // id
      'أشعارات مكنون ', // title
      description:
          "هذه القناة لاشعارك بكل جديد \nيرجئ التحديث للحصول على العروض الجديده", // description
      importance: Importance.high,
    );
  }
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin!
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel!);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  //BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );
  // Workmanager().registerOneOffTask("task-identifier", "simpleTask");
  Workmanager().registerOneOffTask(
    "task-identifier",
    'simpleTask', // Ignored on iOS
    initialDelay: const Duration(minutes: 15),
    constraints: Constraints(
      // connected or metered mark the task as requiring internet
      networkType: NetworkType.connected,
      // require external power
      requiresCharging: true,
    ),
// fully supported
  );
// Periodic task registration
  Workmanager().registerPeriodicTask(
    "periodic-task-identifier",
    "simplePeriodicTask",
    initialDelay: const Duration(minutes: 1),
    constraints: Constraints(
      // connected or metered mark the task as requiring internet
      networkType: NetworkType.connected,
      // require external power
      requiresCharging: true,
    ),

    // When no frequency is provided the default 15 minutes is set.
    // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min if you have configured a lower frequency.
    frequency: const Duration(minutes: 15),
  );
  runApp(const MyApp());
}

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    DataSyncController dataSyncController = await Get.put(
        DataSyncController(isUploadToServer: true),
        permanent: true);
    dataSyncController.initFilds();
    dataSyncController.userLogin = await UserService().getUserLocal;
    await dataSyncController.loadChangedDataLocal();
    if (dataSyncController.userLogin != null &&
        dataSyncController.isNoChanges) {
      final prefs = await SharedPreferences.getInstance();
      String? date = prefs.getString('updated_data');
      if (date != null) {
        DateTime? dateTimeUpload = DateTime.tryParse(date);
        if (dateTimeUpload != null) {
          //final def = DateTime.now().difference(dateTimeUpload);
          if (DateFormat('EEEE').format(DateTime.now()).toLowerCase() ==
                  'friday' &&
              DateTime.now().hour >= 3 &&
              DateTime.now().hour <= 7) {
            await dataSyncController.loadDataSaveLocalOnBackground();
          }
        }

        prefs.setString('updated_data', DateTime.now().toString());
      } else {
        prefs.setString('updated_data', DateTime.now().toString());
      }
    }
    return Future.value(true);
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  // print('Handling a background message ${message.messageId}');
  // print(message.data);

  flutterLocalNotificationsPlugin!.show(
    message.notification.hashCode,
    message.notification?.title,
    message.notification?.body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel?.id ?? '',
        channel?.name ?? '',
        channelDescription: channel?.description ?? '',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableLights: true,
        //sound: const RawResourceAndroidNotificationSound('sound')
      ),
    ),
    //payload: 'Default Sound'
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Locale? locale = Translation.locale;
    return GetMaterialApp(
      title: locale.languageCode == 'ar' ? "مكنون" : "Maknoon",
      defaultTransition: Transition.fade,
      theme: ThemeLight.themeLight,
      darkTheme: ThemeDark.themeDark,
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      locale: Translation.locale,
      fallbackLocale: Translation.fallbackLocale,
      translations: Translation(),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late SharedPreferences prefs;
  bool isHome = false;
  bool isclose = false;
  bool isStartOpcity = false;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    SizeConfig('initialSize').init(originalWidth: 428, originalHeight: 926);
    Constants().getConstants();
    bool isWorkLocal = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //await FirebaseMessaging.instance.subscribeToTopic('ms');
      //gettingData = true ;
      prefs = await SharedPreferences.getInstance();
      if (prefs.getString('userName') != null) {
        isHome = true;
      }
      isWorkLocal = await DataSyncService().getIsWorkLocal;
      AuthModel? userLogin = await UserService().getUserLocal;
      await FirebaseMessaging.instance.subscribeToTopic('AllUsers');
      //await FirebaseMessaging.instance.subscribeToTopic('ms');
      if (userLogin != null) {
        await FirebaseMessaging.instance
            .subscribeToTopic('teacher_${userLogin.teachId}');
      }
      var initialzationSettingsAndroid =
          const AndroidInitializationSettings('@mipmap/maknoon');
      var initialzationSettingsios = const DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: initialzationSettingsAndroid, iOS: initialzationSettingsios);
      flutterLocalNotificationsPlugin!.initialize(initializationSettings);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null && !kIsWeb) {
          flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel?.id ?? '',
                channel?.name ?? '',
                channelDescription: channel?.description ?? '',
                importance: Importance.max,
                priority: Priority.high,
                icon: android.smallIcon,
                playSound: true,
                enableLights: true,
                //sound: const RawResourceAndroidNotificationSound('sound')
              ),
            ),
            //payload: 'Default Sound'
          );
          if (Get.put(HomeController()).currentPageIndex == 2) {
            HomeController homeController = Get.find<HomeController>();
            homeController.loadNotifications(
              homeController.userLogin!.teachId.toString(),
            );
          }
        }
      });
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        if (prefs.getString('userName') != null) {
          if (message.data['open_screen'] == 'notifications') {
            Get.put(HomeController()).currentPageIndex = 2;
            Get.off(() => const Home());
          } else {
            Get.put(HomeController()).currentIndex = 1;
            Get.off(() => const Home());
          }
        } else {
          Get.off(() => const LoginIn());
        }
        await flutterLocalNotificationsPlugin!.cancelAll();
      });

      // gettingData = false ;
    });
    // initIOSPlatformState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isclose = true;
      });
      Timer(const Duration(milliseconds: 500), () {
        setState(() {
          isStartOpcity = true;
        });
      });

      Get.off(
          () => isHome
              ? isWorkLocal
                  ? const Home()
                  : const DataInitialization()
              : const LoginIn(),
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          transition: isHome ? Transition.fadeIn : Transition.downToUp);
    });
  }

  // Future initIOSPlatformState()async{
  //   // Step 1:  Configure BackgroundFetch as usual.
// int status = await BackgroundFetch.configure(BackgroundFetchConfig(
//   minimumFetchInterval: 1
// ), (String taskId) async {  // <-- Event callback.
//   // This is the fetch-event callback.
//   print("[BackgroundFetch] taskId: $taskId");

//   // Use a switch statement to route task-handling.
//   switch (taskId) {
//     case 'com.transistorsoft.customtask':
//      showNotifaction('Received custom task');
//       print("Received custom task");
//       break;
//     default:
//       print("Default fetch task");
//   }
//   // Finish, providing received taskId.
//   BackgroundFetch.finish(taskId);
// }, (String taskId) async {  // <-- Event timeout callback
//   // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
//   print("[BackgroundFetch] TIMEOUT taskId: $taskId");
//   BackgroundFetch.finish(taskId);
// });

// // Step 2:  Schedule a custom "oneshot" task "com.transistorsoft.customtask" to execute 5000ms from now.
// BackgroundFetch.scheduleTask(TaskConfig(
//   taskId: "com.transistorsoft.customtask",
//   delay: 5000  // <-- milliseconds
// ));
// }
// showNotifaction(String message) async {
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     var initialzationSettingsAndroid =
//         const AndroidInitializationSettings('@mipmap/maknoon');
//     var initialzationSettingsios = const IOSInitializationSettings();
//     var initializationSettings = InitializationSettings(
//         android: initialzationSettingsAndroid, iOS: initialzationSettingsios);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     flutterLocalNotificationsPlugin.show(
//       DateTime.now().microsecond,
//       message,
//       null,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           DateTime.now().microsecond.toString(),
//           'upload',
//           channelDescription: 'upload to server',
//           importance: Importance.max,
//           priority: Priority.high,
//           playSound: true,
//           enableLights: true,
//           //sound: const RawResourceAndroidNotificationSound('sound')
//         ),
//       ),
//       //payload: 'Default Sound'
//     );
//   }

  @override
  Widget build(BuildContext context) {
    final height = Get.size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          AnimatedPositioned(
            height: height,
            duration: const Duration(milliseconds: 700),
            bottom: isclose ? 150.h : 0,
            child: AnimatedOpacity(
              opacity: isStartOpcity ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: SvgPicture.asset(
                'images/maknoon_icon.svg',
                height: !isclose ? 72.h : 150.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
