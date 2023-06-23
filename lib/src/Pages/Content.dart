import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Model/chapter_model.dart';
import 'epub_display.dart';

// ignore: must_be_immutable
class ChaptersList extends StatelessWidget {
  List<Chaptermodel> chapters = [];
  ChaptersList({super.key, required this.chapters});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: bag,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: bag,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop(false);
            },
            child: Icon(
              Icons.close,
              color: fontc,
            )),
        centerTitle: true,
        title: const Text(
          "Contents",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xffcc2b73)),
        ),
      ),
      body: Container(
        color: bag,
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: chapters.length,
            itemBuilder: (context, i) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      selectedchapter = chapters[i].chapter;
                      Navigator.of(context).pop(true);
                    },
                    title: Padding(
                      padding: EdgeInsets.only(
                          left: chapters[i].issubchapter ? 15 : 0),
                      child: Text(chapters[i].chapter,
                          style: TextStyle(
                              color: selectedchapter == chapters[i].chapter
                                  ? const Color(0xffcc2b73)
                                  : fontc,
                              fontFamily:
                                  GoogleFonts.getFont(selectedFont).fontFamily,
                              fontSize: 15,
                              fontWeight: chapters[i].issubchapter
                                  ? FontWeight.w400
                                  : FontWeight.w800)),
                    ),
                    dense: true,
                  ),
                  const Divider(height: 0, thickness: 1.0),
                ],
              );
            }),
      ),
    ));
  }
}
