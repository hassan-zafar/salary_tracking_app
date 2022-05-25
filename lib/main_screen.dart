import 'package:flutter/material.dart';
import 'package:salary_tracking_app/widgets/bottom_bar.dart';

class MainScreens extends StatelessWidget {
  static const routeName = '/MainScreen';
  const MainScreens({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        // HomePage()
        BottomBarScreen(),
      ],
    );
  }
}
