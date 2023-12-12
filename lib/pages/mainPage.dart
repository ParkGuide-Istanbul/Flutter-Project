import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';
import '../patterns/config.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //final String _username = UsernameSingleton.getInstance().getUsername();
  final String _username =
      Config.getUsername() == '' ? "devrim2" : Config.getUsername();
  final _drawerKey = GlobalKey<DrawerControllerState>();

  final String avatarImage = Config.getProfilePicture();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
      ),
      drawer: Drawer(
        key: _drawerKey,
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
                        backgroundImage: AssetImage(avatarImage),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        _username,
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
                Navigator.of(context).pop();
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: Text(
                "Home",
                style: CustomTextStyles.drawerMenuTextStyle(),
                textAlign: TextAlign.left,
              ),
            ),
            ListTile(
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
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Container(
              decoration: BoxDecoration(
                  color: CustomColors.customGrey(),
                  borderRadius: BorderRadius.circular(16)),
              child: TextFormField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: CustomColors.middlePurple()),
                  labelText: 'Where are you going to?',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            alignment: Alignment.centerLeft,
            child: Text(
              "Quick Searches",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: CustomColors.middlePurple(),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: CustomColors.customGrey()),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: CustomColors.darkGrey(),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Barbaros Meydanı, Beşiktaş/Istanbul",
                        style: TextStyle(
                            color: CustomColors.middlePurple(), fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "İTÜ Taşkışla Yerleşkesi, Beyoğlu/Istanbul",
                        style: TextStyle(
                            color: CustomColors.middlePurple(), fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: CustomColors.darkGrey()),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Şükrü Saraçoğlu Stadyumu, Kadıköy/Istanbul",
                        style: TextStyle(
                            color: CustomColors.middlePurple(), fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Sabiha Gökçen Havalimanı, Pendik/Istanbul",
                        style: TextStyle(
                            color: CustomColors.middlePurple(), fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
