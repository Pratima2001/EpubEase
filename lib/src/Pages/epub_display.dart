import 'package:epubx/epubx.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Component/theme.dart';
import 'content.dart';
import '../Model/chapter_model.dart';

late String selectedFont;
String selectedchapter = 'Select chapter';
Color bag = Colors.white;
Color fontc = Colors.black;
int themeid = 3;

// ignore: must_be_immutable
class ShowEpub extends StatefulWidget {
  String html1;

  EpubBook epubBook;
  List splithtml = [];

  ShowEpub({
    super.key,
    required this.html1,
    required this.epubBook,
  });
  @override
  State<StatefulWidget> createState() => Home();
}

class Home extends State<ShowEpub> {
  String htmlcontent = '';
  int press = 1;
  var htmlcontent1 = '';
  bool change = false;
  bool show = false;
  final controller = ScrollController();
  List<Chaptermodel> chapterslist1 = [];
  String selectedtext = '';
  String title = "";
  double _fontsizeprogress = 17.0;
  double _fontsize = 17.0;
  bool speak = false;
  String docid = "";

  String fontstyle = 'Montserrat-Medium'.toString();

  bool darkmode = false;

  String parsedstring = '';
  late EpubBook epubBook;
  String booktitle = '';
  var text = '';
  double brightnessLevel = 0.5;
  bool showhtmlwidgt = false;
  late Widget html;
  late Map<String, String> allFonts;
  // Initialize with the first font in the list
  late String selectedTextStyle;
  late List<String> fontNames;

  bool showheader = true;
  bool showprevious = false;
  bool shownext = false;

  @override
  void initState() {
    htmlcontent = widget.html1;
    epubBook = widget.epubBook;
    allFonts = GoogleFonts.asMap().cast<String, String>();
    fontNames = allFonts.keys.toList();
    selectedFont = 'Abyssinica SIL';
    selectedTextStyle = GoogleFonts.getFont(selectedFont).fontFamily!;

    getTitleFromXhtml(widget.html1);
    super.initState();
  }

  getTitleFromXhtml(String xhtml) {
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward &&
          showheader == false) {
        showheader = true;
        setState(() {});
      } else if (controller.position.userScrollDirection ==
              ScrollDirection.reverse &&
          showheader) {
        showheader = false;
        setState(() {});
      }
    });
    if (epubBook.Title != null) {
      booktitle = epubBook.Title!;
    }

    setState(() {});
    showchapter();
  }

  showchapter() async {
    epubBook.Chapters?.forEach((EpubChapter chapter) {
      String? chapterTitle = chapter.Title;
      selectedchapter = '';
      List<Chaptermodel> subChapters = [];
      for (var element in chapter.SubChapters!) {
        subChapters
            .add(Chaptermodel(chapter: element.Title!, issubchapter: true));
      }
      chapterslist1
          .add(Chaptermodel(chapter: chapterTitle!, issubchapter: false));
      chapterslist1 += subChapters;
    });
  }

  updatecontent1() async {
    String content = '';

    epubBook.Chapters?.forEach((EpubChapter chapter) {
      String? chapterTitle = chapter.Title;

      if (chapterTitle?.toLowerCase() == selectedchapter.toLowerCase()) {
        content = chapter.HtmlContent!;
        List<EpubChapter>? subChapters = chapter.SubChapters;
        if (subChapters != null && subChapters.isNotEmpty) {
          for (int i = 0; i < subChapters.length; i++) {
            content = content + subChapters[i].HtmlContent!;
          }
        }
      } else {
        List<EpubChapter>? subChapters = chapter.SubChapters;
        subChapters?.forEach((element) {
          if (element.Title == selectedchapter) {
            content = element.HtmlContent!;
          }
        });
      }
    });
    htmlcontent = content;
    int index = chapterslist1
        .indexWhere((element) => element.chapter == selectedchapter);
    setState(() {
      if (index == 0) {
        showprevious = false;
      } else {
        showprevious = true;
      }
      if (index == chapterslist1.length - 1) {
        shownext = false;
      } else {
        shownext = true;
      }
    });
  }

  Future<bool> backpress() async {
    // Navigator.of(context).pop();
    return true;
  }

  void setBrightness(double brightness) async {
    await ScreenBrightness().setScreenBrightness(brightness);
    setState(() {});
    await Future.delayed(const Duration(seconds: 5));
    show = false;
  }

  updatefontsettings() {
    return showModalBottomSheet(
        context: context,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        backgroundColor: bag,
        enableDrag: true,
        shape: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        builder: (context) {
          return SingleChildScrollView(
              child: StatefulBuilder(
                  builder: (BuildContext context, setState) => SizedBox(
                        height: 170,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              height: 45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      updatetheme(1);
                                    },
                                    child: Customwidget(
                                        bag: const Color(0xffE2E2EF),
                                        fontc: Colors.black,
                                        id: 1),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      updatetheme(2);
                                    },
                                    child: Customwidget(
                                        bag: const Color(0xffE2E5EA),
                                        fontc: Colors.black,
                                        id: 2),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      updatetheme(3);
                                    },
                                    child: Customwidget(
                                        id: 3,
                                        bag: Colors.white,
                                        fontc: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      updatetheme(4);
                                    },
                                    child: Customwidget(
                                        id: 4,
                                        bag: Colors.black,
                                        fontc: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      updatetheme(5);
                                    },
                                    child: Customwidget(
                                        id: 5,
                                        bag: const Color(0xffffdedb),
                                        fontc: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              height: 0,
                              indent: 0,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                                StateSetter setState) =>
                                            Theme(
                                          data: Theme.of(context)
                                              .copyWith(canvasColor: bag),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                                value: selectedFont,
                                                isExpanded: true,
                                                menuMaxHeight: 400,
                                                onChanged: (newValue) {
                                                  selectedFont = newValue!;
                                                  selectedTextStyle =
                                                      GoogleFonts.getFont(
                                                              selectedFont)
                                                          .fontFamily!;

                                                  setState(() {});
                                                  update();
                                                },
                                                items: fontNames.map<
                                                    DropdownMenuItem<
                                                        String>>((String font) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: font,
                                                    child: Text(font,
                                                        style: TextStyle(
                                                            color:
                                                                selectedFont ==
                                                                        font
                                                                    ? const Color(
                                                                        0xffcc2b73)
                                                                    : fontc,
                                                            fontWeight:
                                                                selectedFont ==
                                                                        font
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .normal)),
                                                  );
                                                }).toList()),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Aa",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: fontc,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Slider(
                                              activeColor: themeid == 4
                                                  ? Colors.grey.withOpacity(0.8)
                                                  : Colors.blue,
                                              value: _fontsizeprogress,
                                              min: 0.0,
                                              max: 50.0,
                                              onChangeEnd: (double value) {
                                                _fontsize = value;
                                                update();
                                              },
                                              onChanged: (double value) {
                                                _fontsizeprogress = value;
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          Text(
                                            "Aa",
                                            style: TextStyle(
                                                color: fontc,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      )));
        });
  }

  updatetheme(int id) {
    themeid = id;
    if (id == 1) {
      bag = const Color(0xffE2E2EF);
      fontc = Colors.black;
    } else if (id == 2) {
      bag = const Color(0xffE2E5EA);
      fontc = Colors.black;
    } else if (id == 3) {
      bag = Colors.white;
      fontc = Colors.black;
    } else if (id == 4) {
      bag = Colors.black;
      fontc = Colors.white;
    } else {
      bag = const Color(0xffffdedb);
      fontc = Colors.black;
    }
    Navigator.of(context).pop();
    setState(() {});
  }

  update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
          onWillPop: backpress,
          child: Scaffold(
            body: Container(
                color: bag,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                            child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Scrollbar(
                                controller: controller,
                                child: SingleChildScrollView(
                                  controller: controller,
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 3, top: 50),
                                      alignment: Alignment.center,
                                      child: HtmlWidget(
                                        htmlcontent,
                                        onTapUrl: (String? s) async {
                                          if (s != null && s == "a") {
                                            if (s.contains("chapter")) {
                                              setState(() {
                                                var s1 = s.split("-0");
                                                String break1 = s1
                                                    .toList()
                                                    .last
                                                    .split(".xhtml")
                                                    .first;
                                                int number = int.parse(break1);
                                                selectedchapter = s1.first +
                                                    number.toString();
                                                updatecontent1();
                                              });
                                            }
                                          }
                                          return true;
                                        },
                                        textStyle: TextStyle(
                                            fontSize: _fontsize,
                                            fontFamily: selectedTextStyle,
                                            color: fontc),
                                      )),
                                ),
                              ),
                            ),
                            //)

                            Align(
                              alignment: Alignment.bottomRight,
                              child: Visibility(
                                visible: show,
                                child: Container(
                                    height: 150,
                                    width: 30,
                                    alignment: Alignment.bottomCenter,
                                    margin: const EdgeInsets.only(
                                        bottom: 40, right: 15),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.brightness_7,
                                          size: 15,
                                          color: fontc,
                                        ),
                                        SizedBox(
                                          height: 120,
                                          width: 30,
                                          child: RotatedBox(
                                              quarterTurns: -1,
                                              child: SliderTheme(
                                                  data: SliderThemeData(
                                                    activeTrackColor:
                                                        themeid == 4
                                                            ? Colors.white
                                                            : Colors.blue,
                                                    disabledThumbColor:
                                                        Colors.transparent,
                                                    inactiveTrackColor: Colors
                                                        .grey
                                                        .withOpacity(0.5),
                                                    trackHeight: 5.0,

                                                    thumbColor: themeid == 4
                                                        ? Colors.grey
                                                            .withOpacity(0.8)
                                                        : Colors.blue,
                                                    thumbShape:
                                                        const RoundSliderThumbShape(
                                                            enabledThumbRadius:
                                                                0.0), // Adjust the size of the thumb
                                                    overlayShape:
                                                        const RoundSliderOverlayShape(
                                                            overlayRadius:
                                                                10.0), // Adjust the size of the overlay
                                                  ),
                                                  child: Slider(
                                                    value: brightnessLevel,
                                                    min: 0.0,
                                                    max: 1.0,
                                                    onChangeEnd:
                                                        (double value) {
                                                      setBrightness(value);
                                                    },
                                                    onChanged: (double value) {
                                                      setState(() {
                                                        brightnessLevel = value;
                                                      });
                                                    },
                                                  ))),
                                        ),
                                      ],
                                    )),
                              ),
                            )
                          ],
                        )),
                        if (selectedchapter.isNotEmpty) ...[
                          Container(
                            height: 35,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Visibility(
                                  visible: showprevious,
                                  child: IconButton(
                                      onPressed: () {
                                        int index = chapterslist1.indexWhere(
                                            (element) =>
                                                element.chapter ==
                                                selectedchapter);
                                        if (index != 0) {
                                          selectedchapter =
                                              chapterslist1[index - 1].chapter;
                                          updatecontent1();
                                        }
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 15,
                                        color: fontc,
                                      )),
                                ),
                                Expanded(
                                  child: Text(
                                    selectedchapter,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: selectedTextStyle,
                                        fontWeight: FontWeight.bold,
                                        color: fontc),
                                  ),
                                ),
                                Visibility(
                                    visible: shownext,
                                    child: IconButton(
                                        onPressed: () {
                                          int index = chapterslist1.indexWhere(
                                              (element) =>
                                                  element.chapter ==
                                                  selectedchapter);
                                          if (index !=
                                              chapterslist1.length - 1) {
                                            selectedchapter =
                                                chapterslist1[index + 1]
                                                    .chapter;
                                            updatecontent1();
                                          }
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 15,
                                          color: fontc,
                                        ))),
                              ],
                            ),
                          ),
                        ]
                      ],
                    ),
                    AnimatedContainer(
                      height: showheader ? 50 : 0,
                      duration: const Duration(milliseconds: 10),
                      color: bag,
                      child: AppBar(
                        centerTitle: true,
                        title: Text(
                          booktitle,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: fontc),
                        ),
                        backgroundColor: bag,
                        elevation: 0,
                        leading: IconButton(
                          onPressed: () async {
                            bool updatecontent = await Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => ChaptersList(
                                          chapters: chapterslist1,
                                        )));
                            if (updatecontent) {
                              updatecontent1();
                            }
                          },
                          icon: Icon(
                            Icons.menu,
                            color: fontc,
                          ),
                        ),
                        actions: [
                          InkWell(
                              onTap: () {
                                updatefontsettings();
                              },
                              child: Container(
                                width: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  "Aa",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: fontc,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                              onTap: () async {
                                setState(() {
                                  show = true;
                                });
                                await Future.delayed(
                                    const Duration(seconds: 7));
                                setState(() {
                                  show = false;
                                });
                              },
                              child: Icon(
                                Icons.brightness_high_sharp,
                                size: 20,
                                color: fontc,
                              )),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          )),
    );
  }
}

// ignore: must_be_immutable
