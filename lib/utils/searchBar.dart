import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';

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
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(32),
      child: CupertinoSearchTextField(
        backgroundColor: CustomColors.customGrey(),
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
    );
  }
}
