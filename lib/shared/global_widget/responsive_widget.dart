import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    Key? key,
    required this.phone,
    this.desktop,
    this.tablet,
  }) : super(key: key);
  final Widget phone;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1100) {
        return desktop ?? tablet ?? phone;
      } else if (constraints.maxWidth >= 600 && constraints.maxWidth < 1100) {
        return tablet ?? phone;
      } else {
        return phone;
      }
    });
  }
}
