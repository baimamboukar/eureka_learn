import 'package:eureka_learn/utils/screen.dart';
import 'package:flutter/widgets.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsive({
    required Key key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (Screen.isMobile(context)) {
        return mobile;
      } else if (Screen.isTblet(context)) {
        return tablet;
      } else if (Screen.isDesktop(context)) {
        return desktop;
      } else {
        return mobile;
      }
    });
  }
}
