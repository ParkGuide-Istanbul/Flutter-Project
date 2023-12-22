import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/pages/mainPage.dart';
import 'package:park_guide_istanbul/patterns/config.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';

import '../pages/profile.dart';

enum inputType { EMAIL, PASSWORD, NAME, SURNAME, DATE_OF_BIRTH }

enum PAGE { MAIN, PROFILE }

PreferredSize mainAppBar() => PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.middlePurple(),
        title: Padding(
          padding: const EdgeInsets.only(right: 32),
          child: Image.asset(
            "assets/parkguide-removebg.png",
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
    );

OutlinedButton customButton(
    {required String label, required void Function() onPressed}) {
  return OutlinedButton(
    onPressed: onPressed,
    child: Text(label),
    style: OutlinedButton.styleFrom(
      backgroundColor: CustomColors.darkPurple(),
      primary: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: const TextStyle(
        fontSize: 16,
      ),
    ),
  );
}

PreferredSize preLoginAppBar(
    {required String label, required BuildContext context}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
    child: AppBar(
      shadowColor: CustomColors.middlePurple(),
      elevation: 0,
      title: const Text(''),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              CustomColors.darkPurple(),
              CustomColors.darkPurple(),
              CustomColors.darkPurple()
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
      foregroundColor: Colors.white,
    ),
  );
}

Drawer customDrawer({required context, required PAGE pageName}) => Drawer(
      backgroundColor: CustomColors.customGrey(),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: CustomColors.middlePurple()),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(Config.getProfilePicture()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      Config.getUsername(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            onTap: () {
              if (pageName == PAGE.MAIN) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(builder: (context) => MainPage()));
              }
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              "Home",
              style: CustomTextStyles.drawerMenuTextStyle(),
              textAlign: TextAlign.left,
            ),
          ),
          ListTile(
            onTap: () {
              if (pageName == PAGE.PROFILE) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(builder: (context) => ProfilePage()));
              }
            },
            tileColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              "Profile",
              style: CustomTextStyles.drawerMenuTextStyle(),
              textAlign: TextAlign.left,
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              "Settings",
              style: CustomTextStyles.drawerMenuTextStyle(),
              textAlign: TextAlign.left,
            ),
          ),
          ListTile(
            tileColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              "Report",
              style: CustomTextStyles.drawerMenuTextStyle(),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
