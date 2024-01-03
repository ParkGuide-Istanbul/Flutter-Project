import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/patterns/config.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';

import '../utils/helper.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final String _profilePictureURL = Config.getProfilePicture();
  final String _username = Config.getUsername();
  final String _password = Config.getPassword();
  final String _name = Config.getName();
  final String _surname = Config.getSurname();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/ortakoy_mosq.png'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                  alignment: Alignment.center)),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                  child: CircleAvatar(
                backgroundImage: AssetImage(_profilePictureURL),
                radius: 75,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Container(
                decoration: BoxDecoration(
                    color: CustomColors.customGrey(),
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text("Username: ",
                            style: CustomTextStyles.drawerMenuTextStyle()),
                        Text(
                          _username,
                          style: TextStyle(
                              color: CustomColors.lightPurple(), fontSize: 20),
                        )
                      ]),
                      Row(children: <Widget>[
                        Text("Name: ",
                            style: CustomTextStyles.drawerMenuTextStyle()),
                        Text(
                          _name,
                          style: TextStyle(
                              color: CustomColors.lightPurple(), fontSize: 20),
                        )
                      ]),
                      Row(children: <Widget>[
                        Text("Surname: ",
                            style: CustomTextStyles.drawerMenuTextStyle()),
                        Text(
                          _surname,
                          style: TextStyle(
                              color: CustomColors.lightPurple(), fontSize: 20),
                        )
                      ]),
                      Row(children: <Widget>[
                        Text("Password: ",
                            style: CustomTextStyles.drawerMenuTextStyle()),
                        Text(
                          "**",
                          style: TextStyle(
                              color: CustomColors.lightPurple(), fontSize: 20),
                        )
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
