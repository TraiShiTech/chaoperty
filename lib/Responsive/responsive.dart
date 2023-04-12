import 'package:flutter/material.dart';

//https://github.com/ShubhranshuArya/Responsive-web-ui?ref=flutterawesome.com
class Responsive extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? smallMobile;

  const Responsive(
      {Key? key,
      required this.mobile,
      this.tablet,
      required this.desktop,
      this.smallMobile})
      : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop help us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 400 &&
      MediaQuery.of(context).size.height < 400; //768

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1000 &&
      MediaQuery.of(context).size.width >= 400 &&
      MediaQuery.of(context).size.height < 550 &&
      MediaQuery.of(context).size.height >= 450; //768

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1000 &&
      MediaQuery.of(context).size.height >= 450; //1200

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final Size _Hi = MediaQuery.of(context).size;
    // If our width is more than 1200 then we consider it a desktop
    if (_size.width >= 1000 && _Hi.height >= 50) {
      return desktop!;
    }
    // If width it less then 1200 and more then 768 we consider it as tablet
    else if (_size.width >= 768 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else if (_size.width >= 376 && _size.width <= 400 && mobile != null) {
      return mobile!;
    } else {
      return smallMobile!;
    }
  }
}
