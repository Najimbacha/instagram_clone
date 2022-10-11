import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/dimentions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webscreenlayout;
  final Widget mobscreenlayout;

  const ResponsiveLayout(
      {super.key,
      required this.mobscreenlayout,
      required this.webscreenlayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webscreensize) {
          return webscreenlayout;
        }

        return mobscreenlayout;
      },
    );
  }
}
