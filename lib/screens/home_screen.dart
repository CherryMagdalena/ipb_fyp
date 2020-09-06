import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:ipb_fyp/components/floating_action_button.dart';
import 'package:ipb_fyp/model/contact_list.dart';
import 'package:ipb_fyp/resources/color.dart';
import 'package:ipb_fyp/components/bottom_app_bar.dart';
import 'package:ipb_fyp/screens/offline_home_screen.dart';
import 'package:ipb_fyp/screens/online_home_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingButton(),
      bottomNavigationBar: CustomBottomAppBar(),
      backgroundColor: kBackgroundColor,
      body: PageView(controller: pageController, children: [
        OnlineHomeScreen(pageController),
        OfflineHomeScreen(pageController)
      ]),
    );
  }
}
