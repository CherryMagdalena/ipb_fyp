import 'package:flutter/material.dart';
import 'package:ipb_fyp/resources/text_style.dart';

class OnlineOrOfflineText extends StatelessWidget {
  final bool isOnline;
  final PageController pageController;
  OnlineOrOfflineText(this.pageController, {@required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
            child: Text(
              'Online',
              style: isOnline ? kSelectedTextStyle : kUnselectedTextStyle,
            ),
            onTap: () {
              pageController.animateToPage(0,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            }),
        Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Text(
            '|',
            style: kUnselectedTextStyle,
          ),
        ),
        GestureDetector(
            child: Text(
              'Offline',
              style: isOnline ? kUnselectedTextStyle : kSelectedTextStyle,
            ),
            onTap: () {
              pageController.animateToPage(1,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            }),
      ],
    );
  }
}
