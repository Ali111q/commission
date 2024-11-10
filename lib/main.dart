import 'package:Trip/config/bindings/binding_controllers.dart';
import 'package:Trip/config/constant.dart';
import 'package:Trip/config/themes/theme_generator.dart';
import 'package:Trip/l10n/locals.g.dart';
import 'package:Trip/pages/splash/splash_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'config/const_wodget/custom_scaffold.dart';

late SharedPreferences prefs;
late List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SunmiPrinter.bindingPrinter(); // Bind the printer first

  timeago.setLocaleMessages("ar", timeago.ArMessages());

  prefs = await SharedPreferences.getInstance();
  // prefs.clear();
  Get.changeThemeMode(ThemeMode.light);
  cameras = await availableCameras();
  LocationPermission locationPermission = await Geolocator.checkPermission();
  if (locationPermission != LocationPermission.whileInUse ||
      locationPermission != LocationPermission.always) {
    Geolocator.requestPermission();
  }

  GeocodingPlatform.instance?.setLocaleIdentifier("ar");

  Get.updateLocale(Locale('ar'));

  runApp(MyApp(page: SplashPage()));
}

class MyApp extends StatefulWidget {
  final Widget page;

  const MyApp({
    super.key,
    required this.page,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        final theme = AppTheme();
        // SizeConfig().init(constraints, orientation);
        return GetMaterialApp(
          routes: {
            '/': (context) => widget.page,
          },
          debugShowCheckedModeBanner: false,
          initialBinding: BindingsController(),
          initialRoute: '/',
          title: "Structure",
          translationsKeys: AppTranslation.translations,
          // locale: Get.locale!,
          supportedLocales: const [
            Locale("ar", "SA"),
            Locale("en", "US"),
          ],
          fallbackLocale: const Locale("ar", "AR"),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: theme.buildLightTheme(),
          themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: theme.buildDarkTheme(),
          builder: (context, child) {
            return ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            );
          },
        );
      });
    });
  }
}
