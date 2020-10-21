import 'package:flutter/material.dart';
import 'package:ipb_fyp/components/rounded_clipper.dart';
import 'package:ipb_fyp/resources/color.dart';
import 'package:ipb_fyp/resources/text_style.dart';

class PageHeader extends StatelessWidget {
  final String title;
  PageHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: RoundedClipper(),
        child: Container(
          height: 230.0,
          width: double.infinity,
          color: kPrimaryColor,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Center(
              child: Text(
                title,
                style: kHomeScreenTitle,
              ),
            ),
          ]),
        ));
  }
}
