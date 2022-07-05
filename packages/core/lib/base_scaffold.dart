import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    Key? key,
    this.extendBody = false,
    required this.body,
    this.appBar,
    this.backgroundColor,
    this.safeBottom = true,
    this.safeTop = true,
    this.bottomNavigationBar,
    this.withSafeArea = false,
    this.resizeToAvoidBottomInset = true,
    this.onBackPressed,
  }) : super(key: key);

  final Widget? bottomNavigationBar;
  final bool extendBody;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final bool withSafeArea;
  final bool safeBottom;
  final bool safeTop;
  final Widget body;
  final bool resizeToAvoidBottomInset;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (onBackPressed != null) onBackPressed!();
        return true;
      },
      child: Scaffold(
        appBar: appBar,
        backgroundColor: backgroundColor,
        body: withSafeArea
            ? SafeArea(
                child: body,
                bottom: safeBottom,
                top: safeTop,
              )
            : body,
        extendBody: extendBody,
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      ),
    );
  }
}
