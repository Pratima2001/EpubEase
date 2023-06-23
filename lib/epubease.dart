library epubease;

import 'dart:async';

import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart' show rootBundle;

import 'epubease.dart';

export 'src/Pages/epub_display.dart';

/// A Calculator.
class Epubease {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<void> openAsset(String assetpath, BuildContext context) async {
    var bytes = await rootBundle.load(assetpath);

    EpubBook epubBook = await EpubReader.readBook(bytes.buffer.asUint8List());

    String htmlcontent = '';
    Map<String, EpubTextContentFile> htmlFiles = epubBook.Content!.Html!;

    for (var htmlFile in htmlFiles.values) {
      htmlcontent = htmlcontent + htmlFile.Content!;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ShowEpub(
              html1: htmlcontent,
              epubBook: epubBook,
            );
          },
        ),
      );
    });
  }

  static Future<void> open(String bookurl, BuildContext context) async {
    final response = await http.get(Uri.parse(bookurl));
    if (response.statusCode == 200) {
      final epubData = response.bodyBytes;

      // Load the EPUB from memory
      EpubBook epubBook = await EpubReader.readBook(epubData);

      String htmlcontent = '';
      Map<String, EpubTextContentFile> htmlFiles = epubBook.Content!.Html!;

      for (var htmlFile in htmlFiles.values) {
        htmlcontent = htmlcontent + htmlFile.Content!;
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ShowEpub(
                html1: htmlcontent,
                epubBook: epubBook,
              );
            },
          ),
        );
      });
    }
  }
}
