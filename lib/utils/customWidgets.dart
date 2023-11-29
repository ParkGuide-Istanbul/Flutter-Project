import 'package:flutter/material.dart';
import 'package:park_guide_istanbul/utils/ui_features.dart';

enum inputType { EMAIL, PASSWORD, NAME, SURNAME, DATE_OF_BIRTH }

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
      elevation: 20,
      title: const Text(''),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              CustomColors.darkPurple(),
              CustomColors.darkPurple(),
              CustomColors.darkPurple()
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
      ),
      foregroundColor: Colors.white,
    ),
  );
}
