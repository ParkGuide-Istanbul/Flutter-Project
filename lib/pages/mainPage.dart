import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';
import '../patterns/config.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
      drawer: MainDrawer(),
      body: const SingleChildScrollView(child: MainBody()),
    );
  }
}

class MainDrawer extends StatefulWidget {
  MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String _username = Config.getUsername();
  String avatarImage = Config.getProfilePicture();

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        MainSearchBar(),
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
        MainQuickSearches(),
      ],
    );
  }
}

class MainSearchBar extends StatefulWidget {
  MainSearchBar({Key? key}) : super(key: key);

  @override
  State<MainSearchBar> createState() => _MainSearchBarState();
}

class _MainSearchBarState extends State<MainSearchBar> {
  TextEditingController _searchBarController = TextEditingController();

  void _searchFromBar() {
    String place = _searchBarController.text;
    print(place);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: CupertinoSearchTextField(
          prefixIcon: Icon(CupertinoIcons.map),
          suffixIcon: Icon(CupertinoIcons.search),
          onSuffixTap: _searchFromBar,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          controller: _searchBarController,
          borderRadius: BorderRadius.circular(16),
          placeholder: "Where are you going to?",
          placeholderStyle:
              TextStyle(color: CustomColors.middlePurple(), fontSize: 20),
          itemColor: CustomColors.middlePurple(),
          itemSize: 25,
          onSubmitted: (val) {
            _searchFromBar();
          },
          autocorrect: true,
        ),
      ),
    );
  }
}

class MainQuickSearches extends StatefulWidget {
  MainQuickSearches({Key? key}) : super(key: key);

  @override
  State<MainQuickSearches> createState() => _MainQuickSearchesState();
}

class _MainQuickSearchesState extends State<MainQuickSearches> {
  //NEED TO WRITE A PROTOCOL TO DYNAMICALLY GET THE QUICK SEARHC SUGGESTIONS!!!
  final List<String> _quickSearches = [
    "Barbaros Meydanı, Beşiktaş/Istanbul",
    "İTÜ Taşkışla Yerleşkesi, Beyoğlu/Istanbul",
    "Şükrü Saraçoğlu Stadyumu, Kadıköy/Istanbul",
    "Sabiha Gökçen Havalimanı, Pendik/Istanbul"
  ];

  void _makeQuickSearch(int index) {
    print(_quickSearches.elementAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: CustomColors.customGrey()),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _makeQuickSearch(0);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: CustomColors.darkGrey(),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _quickSearches.elementAt(0),
                    style: TextStyle(
                        color: CustomColors.middlePurple(), fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _makeQuickSearch(1);
              },
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _quickSearches.elementAt(1),
                    style: TextStyle(
                        color: CustomColors.middlePurple(), fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _makeQuickSearch(2);
              },
              child: Container(
                decoration: BoxDecoration(color: CustomColors.darkGrey()),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _quickSearches.elementAt(2),
                    style: TextStyle(
                        color: CustomColors.middlePurple(), fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _makeQuickSearch(3);
              },
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _quickSearches.elementAt(3),
                    style: TextStyle(
                        color: CustomColors.middlePurple(), fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
