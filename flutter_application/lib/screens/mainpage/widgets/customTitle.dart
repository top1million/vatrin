import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/numbers.dart';

class customTitles extends StatelessWidget {
  customTitles({Key? key, required this.title, required this.whichList})
      : super(key: key);
  String title, whichList;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                    color: logoColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
        ),

      ],
    );
  }
}
