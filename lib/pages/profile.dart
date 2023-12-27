import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/patterns/config.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final String _profilePictureURL = Config.getProfilePicture();
  final String _username = Config.getUsername();
  final String _password = Config.getPassword();
  final String _email = Config.getEmail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      drawer: customDrawer(context: context, pageName: PAGE.PROFILE),
      body: Column(
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
                      Text("E-mail: ",
                          style: CustomTextStyles.drawerMenuTextStyle()),
                      Text(
                        _email,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Center(
              child: OutlinedButton(
                onPressed: () {
                  print("Edit Profile");
                },
                child: Text('Edit Profile'),
                style: OutlinedButton.styleFrom(
                  backgroundColor: CustomColors.middlePurple(),
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
