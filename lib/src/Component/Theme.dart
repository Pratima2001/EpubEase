import 'package:flutter/material.dart';

import '../Pages/epub_display.dart';

// ignore: must_be_immutable
class Customwidget extends StatelessWidget {
  Color bag, fontc;
  int id;
  Customwidget(
      {super.key, required this.bag, required this.fontc, required this.id});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: themeid == id ? const Color(0xffcc2b73) : Colors.grey)),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: bag,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            "T",
            style: TextStyle(color: fontc),
          ),
        ),
      ),
    );
  }
}
