import 'package:base_structure/components/custom_appbar.dart';
import 'package:base_structure/main.dart';
import 'package:base_structure/utils/app_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/check_internet.dart';
import '../../utils/cm_file.dart';
import '../../utils/strings.dart';

///    Created By Bhavesh Makwana on 12/01/23
class BaseScreen extends StatefulWidget {
  final String title;
  final Widget? body;
  final bool? shouldShowNoInternetScreen;
  final bool shouldShowAppbar;
  final bool? shouldShowBackButton;
  final List<Widget>? appbarActions;

  const BaseScreen(
      {Key? key,
      this.title = "",
      this.body,
      this.shouldShowNoInternetScreen = false,
      this.shouldShowAppbar = true,
      this.shouldShowBackButton = true,
      this.appbarActions})
      : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  CheckInternet? _checkInternet;

  @override
  void initState() {
    _checkInternet = Provider.of<CheckInternet>(context, listen: false);
    _checkInternet?.checkRealtimeConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.shouldShowAppbar
          ? CustomAppBar(
              title: widget.title,
              appbarActions: widget.appbarActions,
              shouldShowBackButton: widget.shouldShowBackButton)
          : null,
      body: Consumer<CheckInternet>(builder: (context, provider, child) {
        if (provider.status == "Offline") {
          /// to remove error (setState() or markNeedsBuild called during build)
          /// we use delayed function here
          AppPreference.instance
              .savePrefString(Pref.isInternetConnection, "Offline");
          if (connectionStatus.value == "Online") {
            connectionStatus.value = "Offline";
            Future.delayed(Duration.zero, () async {
              CM.showCustomToast(context, Strings.youAreOffline,
                  isOffline: true, verticalMargin: 11);
            });
          }
        } else {
          if (connectionStatus.value == "Offline") {
            connectionStatus.value = "Online";
            AppPreference.instance
                .savePrefString(Pref.isInternetConnection, "Online");
            Future.delayed(Duration.zero, () async {
              CM.showCustomToast(context, Strings.youAreOnline,
                  verticalMargin: 11);
            });
          }
        }
        return SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          //color: provider.status == "Offline" ? Colors.red : Colors.green,
          child:
              /*provider.status == "Offline" && widget.shouldShowNoInternetScreen!
                  ? const NoInternetScreen()
                  : */
              widget.body,
        );
      }),
    );
  }

  /*getBody() {
    return getScreen();
  }*/

}
