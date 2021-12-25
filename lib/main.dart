import 'package:catcher/catcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_boilerplate/controllers/home_page_controller.dart';
import 'package:flutter_getx_boilerplate/routes/routes.dart';
import 'package:flutter_getx_boilerplate/utils/constants/colors.dart';
import 'package:flutter_getx_boilerplate/utils/services/interceptors/logging_interceptors.dart';

String initialRoute = '/home';

ToastHandler toastHandler() {
  return ToastHandler(
    gravity: ToastHandlerGravity.bottom,
    length: ToastHandlerLength.short,
    backgroundColor: Colors.grey[400]!,
    textColor: Colors.white,
    textSize: 12.0,
    customMessage: "We are sorry but unexpected error occured.",
  );
}

//debug configuration
// TODO: set configuration best practice for development
CatcherOptions debugOptions = CatcherOptions(SilentReportMode(), [
  ConsoleHandler(),
  toastHandler(),
]);

//release configuration
// TODO: set configuration best practice for production
CatcherOptions releaseOptions = CatcherOptions(SilentReportMode(), [
  ConsoleHandler(),
]);

//profile configuration
// TODO: set configuration best practice for profile options
CatcherOptions profileOptions = CatcherOptions(SilentReportMode(), [
  ConsoleHandler(),
  toastHandler(),
]);

Future<void> main() async {
  Catcher(
    runAppFunction: () async {
      WidgetsFlutterBinding.ensureInitialized();

      await FlutterConfig.loadEnvVariables();

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: PRIMARY_TEXT_COLOR,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      );

      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
        (_) async {
          // Make sure firebase initialized before app start
          runApp(MyApp());
        },
      );
    },
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
    profileConfig: profileOptions,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: PRIMARY_COLOR,
        ),
        primaryColor: PRIMARY_COLOR,
        primaryColorDark: DARK_PRIMARY_COLOR,
        primaryColorLight: LIGHT_PRIMARY_COLOR,
        iconTheme: const IconThemeData(
          color: TEXT_ICONS_COLOR,
        ),
        textSelectionTheme: const TextSelectionThemeData(selectionHandleColor: Colors.transparent),
        unselectedWidgetColor: Colors.grey[300],
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ACCENT_COLOR),
      ),
      initialRoute: initialRoute,
      defaultTransition: Transition.native,
      locale: const Locale('id'),
      getPages: pages(),
      initialBinding: InitialBindings(),
    );
  }
}

class InitialBindings extends Bindings {
  Dio _dio() {
    var dio = Dio();

    dio.interceptors.addAll([
      LoggingInterceptor(),
    ]);

    return dio;
  }

  @override
  void dependencies() {
    Get.put(_dio());

    // Put homepage controller
    Get.put(HomePageController());
  }
}
