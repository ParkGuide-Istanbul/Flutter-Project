import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/pages/login.dart';
import 'package:park_guide_istanbul/pages/mainPage.dart';
import 'package:park_guide_istanbul/patterns/config.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';

import '../pages/profile.dart';
import '../pages/report.dart';

enum inputType { EMAIL, PASSWORD, NAME, SURNAME, DATE_OF_BIRTH }

enum PAGE { MAIN, PROFILE, REPORT }

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
      backgroundColor: CustomColors.middlePurple(),
      primary: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Image.asset(
                  "assets/apple-touch-icon.png",
                  alignment: Alignment.centerLeft,
                  width: 75,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
      foregroundColor: Colors.white,
    ),
  );
}

Drawer customDrawer({required context, required PAGE pageName}) => Drawer(
      //backgroundColor: CustomColors.customGrey(),
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/ortakoy_mosq.png'),
                fit: BoxFit.cover,
                opacity: 0.3,
                alignment: Alignment.center)),
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
              tileColor: pageName == PAGE.MAIN
                  ? CustomColors.middlePurple()
                  : Colors.white,
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
                style: CustomTextStyles.drawerMenuTextStyle(
                    setPurple: pageName == PAGE.MAIN),
                textAlign: TextAlign.left,
              ),
            ),
            ListTile(
              onTap: () {
                if (pageName == PAGE.PROFILE) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();

                  Navigator.of(context).push(
                      CupertinoPageRoute(builder: (context) => ProfilePage()));
                }
              },
              tileColor: pageName == PAGE.PROFILE
                  ? CustomColors.middlePurple()
                  : Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: Text(
                "Profile",
                style: CustomTextStyles.drawerMenuTextStyle(
                    setPurple: pageName == PAGE.PROFILE),
                textAlign: TextAlign.left,
              ),
            ),
            ListTile(
              tileColor: pageName == PAGE.REPORT
                  ? CustomColors.middlePurple()
                  : Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: Text(
                "Report",
                style: CustomTextStyles.drawerMenuTextStyle(
                    setPurple: pageName == PAGE.REPORT),
                textAlign: TextAlign.left,
              ),
              onTap: () {
                if (pageName == PAGE.REPORT) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();

                  Navigator.of(context).push(
                      CupertinoPageRoute(builder: (context) => ReportPage()));
                }
              },
            ),
            ListTile(
              tileColor: Colors.white,
              onTap: () {
                /*Config.clearAll();
  
                  Navigator.of(context).pop();
  
                  Navigator.of(context).pushReplacement(
  
                      CupertinoPageRoute(builder: (context) => LoginPage()));*/

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          title: Text(
                            'LOGOUT',
                            style: CustomTextStyles.drawerMenuTextStyle(),
                          ),
                          content: Text('Do you want to log out?',
                              style: TextStyle(
                                  color: CustomColors.middlePurple())),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();

                                Navigator.of(context).pop();

                                Config.clearAll();

                                Config.setQuickSearchLoaded(value: false);

                                Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                        builder: ((context) =>
                                            LoginPage()))); // Close the AlertDialog
                              },
                              child: Text('YES'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Close the AlertDialog
                              },
                              child: Text('NO'),
                            )
                          ],
                        ));
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: Text(
                "Logout",
                style: CustomTextStyles.drawerMenuTextStyle(),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
