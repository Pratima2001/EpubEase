library epubease;



import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart' show rootBundle;

import 'src/Pages/epub_display.dart';

/// A Calculator.
class Epubease {
  Future<void> openAsset(String assetpath, BuildContext context) async {
    var bytes = await rootBundle.load(assetpath);

    EpubBook epubBook = await EpubReader.readBook(bytes.buffer.asUint8List());

    extractchapeters(epubBook, context);
  }

  Future<void> open(String bookurl, BuildContext context) async {
    final response = await http.get(Uri.parse(bookurl));
    if (response.statusCode == 200) {
      final epubData = response.bodyBytes;

      // Load the EPUB from memory
      EpubBook epubBook = await EpubReader.readBook(epubData);

      extractchapeters(epubBook, context);
    }
  }

  extractchapeters(EpubBook epubBook, BuildContext context) async {
   String htmlcontent = '';
    Map<String, EpubTextContentFile> htmlFiles = epubBook.Content!.Html!;

    for (var htmlFile in htmlFiles.values) {
      htmlcontent = htmlcontent + htmlFile.Content!;
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ShowEpub(html1: htmlcontent, epubBook: epubBook)));
  }
}

