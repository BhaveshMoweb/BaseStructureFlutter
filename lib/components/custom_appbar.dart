import 'package:base_structure/components/custom_title_text.dart';
import 'package:base_structure/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/theme/theme_model.dart';

//ignore: must_be_immutable
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  String title;
  String prefixIcon;
  TextAlign textAlign;
  int maxLines;
  bool? shouldShowBackButton;
  List<Widget>? appbarActions;

  CustomAppBar(
      {Key? key,
      this.title = "",
      this.prefixIcon = "",
      this.textAlign = TextAlign.center,
      this.maxLines = 1,
      this.shouldShowBackButton = false,
      this.appbarActions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Created toolbar for custom appbar
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return AppBar(
        title: CustomTitleText(
          text: title,
        ),
        actions: appbarActions == null
            ? [
                /// Light - Dark mode button
                IconButton(
                  onPressed: () {
                    themeNotifier.isDark
                        ? themeNotifier.isDark = false
                        : themeNotifier.isDark = true;
                  },
                  icon: Icon(themeNotifier.isDark
                      ? Icons.nightlight_round
                      : Icons.wb_sunny),
                )
              ]
            : appbarActions! +
                [
                  IconButton(
                    onPressed: () {
                      themeNotifier.isDark
                          ? themeNotifier.isDark = false
                          : themeNotifier.isDark = true;
                    },
                    icon: Icon(themeNotifier.isDark
                        ? Icons.nightlight_round
                        : Icons.wb_sunny),
                  )
                ],
        backgroundColor: Theme.of(context).backgroundColor,

        /// if back button visible, than we need to give leading with to show icon
        /// and if back button not visible than title show without any starting space
        /// so adding 5.w width
        leadingWidth: shouldShowBackButton! ? 15.w : 0,
        titleSpacing: shouldShowBackButton! ? 0 : 5.w,
        leading: shouldShowBackButton!
            ? IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => Navigator.pop(context),
                color: AppColors.inputBackgroundColor,
              )
            : Container(),
      );
    });
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return const Size.fromHeight(56.0);
  }
}
