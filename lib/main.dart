import 'package:base_structure/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'constants/common_fonts.dart';
import 'screens/authentication/login/login_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/landing_screen/landing_screen.dart';
import 'screens/post_list/post_list_screen.dart';
import 'screens/product_list/product_list_screen.dart';
import 'utils/check_internet.dart';
import 'utils/cm_file.dart';
import 'utils/routes.dart';
import 'utils/theme/theme_model.dart';

/// below connection status variable used to manage show online-offline toast
/// only once when you navigate to multiple screen
ValueNotifier<String> connectionStatus = ValueNotifier("Online");

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(ChangeNotifierProvider(
      create: (_) => CheckInternet(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    final window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      /*final brightness =*/ window.platformBrightness;
    };
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    CM.printLog("Theme changed");
    super.didChangePlatformBrightness();
  }

  ThemeData get _lightTheme => ThemeData(
        brightness: Brightness.light,
        backgroundColor: AppColors.inputTextColor,
        textTheme: TextTheme(
          displayMedium: TextStyle(
            fontFamily: CommonFonts.sourceSansProSemiBold,
            color: AppColors.appBarHeadingColor,
            fontSize: 16,
          ),
          headlineMedium: TextStyle(
              fontFamily: CommonFonts.sourceSansProSemiBold,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.appBarHeadingColor),
        ),
      );

  ThemeData get _darkTheme => ThemeData(
        brightness: Brightness.dark,
        backgroundColor: AppColors.offlineTextColor,
        textTheme: TextTheme(
          displayMedium: TextStyle(
            fontFamily: CommonFonts.sourceSansProSemiBold,
            color: AppColors.inputBackgroundColor,
            fontSize: 16,
          ),
          headlineMedium: TextStyle(
              fontFamily: CommonFonts.sourceSansProSemiBold,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.inputBackgroundColor),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeNotifier.isDark ? _darkTheme : _lightTheme,

            /// When navigating to the "/" route, build the Landing Screen widget.
            initialRoute: '/',
            routes: {
              '/': (context) => const LandingScreen(),
              Routes.productList: (context) => const ProductListScreen(),
              Routes.loginScreen: (context) => const LoginScreen(),
              Routes.postListScreen: (context) => const PostListScreen(),
              Routes.dashboardScreen: (context) => const DashboardScreen(),
            },
          );
        }),
      );
    });
  }
}
