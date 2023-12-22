import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/utils/customWidgets.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';
import '../utils/searchBar.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      drawer: const MainDrawer(),
      body: const SingleChildScrollView(child: MainBody()),
    );
  }
}

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return customDrawer(context: context, pageName: PAGE.MAIN);
  }
}

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bogaz2.jpg"), fit: BoxFit.cover)),
            child: MainSearchBar()),
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
        const MainQuickSearches(),
      ],
    );
  }
}

class MainQuickSearches extends StatefulWidget {
  const MainQuickSearches({Key? key}) : super(key: key);

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
