import 'package:base_structure/utils/app_preference.dart';
import 'package:base_structure/utils/cm_file.dart';
import 'package:base_structure/utils/strings.dart';
import 'package:flutter/material.dart';

import '../../utils/routes.dart';

///    Created By Bhavesh Makwana on 18/01/23
class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();

    /// below method call once
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigateToLoginScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  Future<void> navigateToLoginScreen() async {
    AppPreference.instance.getPrefBoolean(Pref.isLoggedIn).then((value) {
      if (value == true) {
        if (!mounted) return;
        CM.callNextScreen(context, Routes.dashboardScreen);
      } else {
        if (!mounted) return;
        CM.callNextScreen(context, Routes.loginScreen);
      }
    });
  }
}
