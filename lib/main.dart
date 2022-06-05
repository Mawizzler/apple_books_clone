import 'dart:ui';

import 'package:apple_books_clone/pages/book_page.dart';
import 'package:apple_books_clone/widgets/PopupMenuItem.dart';
import 'package:apple_books_clone/widgets/ShareSheet.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List pages = [HomePage(), MyHomePage()];
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.book_fill,
              size: 25,
            ),
            label: 'Jetzt Lesen',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.bookmark_fill,
              size: 25,
            ),
            label: 'Bibliothek',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return pages[index];
          },
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showNavBorder = false;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    print(_controller.offset);
    if (_controller.offset > 35 && !showNavBorder) {
      setState(() {
        showNavBorder = true;
      });
    }
    if (_controller.offset < 35 && showNavBorder) {
      setState(() {
        showNavBorder = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(controller: _controller, slivers: [
      // The CupertinoSliverNavigationBar
      CupertinoSliverNavigationBar(
        padding: const EdgeInsetsDirectional.only(start: 12, end: 12),
        stretch: true,
        leading: Text(""),
        middle: showNavBorder ? Text("Jetzt lesen") : Text(""),
        largeTitle: Row(children: [
          Text('Jetzt lesen'),
          Icon(CupertinoIcons.profile_circled)
        ]),
        border: Border(
            bottom: BorderSide(
          width: 1,
          color: showNavBorder ? Colors.grey.shade300 : Colors.transparent,
        )),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Material(
                type: MaterialType.transparency,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        decoration: const BoxDecoration(
                            border: Border.symmetric(
                                horizontal: BorderSide(color: Colors.black12))),
                        child: ListTile(
                          minVerticalPadding: 0.0,
                          contentPadding: const EdgeInsets.all(0),
                          onTap: () => {},
                          leading: const Icon(
                            CupertinoIcons.text_justifyleft,
                            size: 20,
                          ),
                          title: const Text("Sammlungen"),
                          trailing: const Icon(
                            CupertinoIcons.chevron_forward,
                            size: 16,
                          ),
                        ))));
          },
          childCount: 1, // 1000 list items
        ),
      ),
      SliverFillRemaining(),
    ]));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showAsList = false;
  bool editMode = false;
  bool showNavBorder = false;
  String sortBy = "Zuletzt";
  List<String> sortByItems = ["Zuletzt", "Titel", "Autorin"];
  final ScrollController _controller = ScrollController();
  List<int> selectedItems = [];
  final CustomPopupMenuController _popupcontroller =
      CustomPopupMenuController();

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset > 50 && !showNavBorder) {
      setState(() {
        showNavBorder = true;
      });
    }
    if (_controller.offset < 50 && showNavBorder) {
      setState(() {
        showNavBorder = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      controller: _controller,
      slivers: [
        // The CupertinoSliverNavigationBar
        CupertinoSliverNavigationBar(
          padding: const EdgeInsetsDirectional.only(start: 12, end: 12),
          leading: CupertinoButton(
            padding: const EdgeInsets.all(0),
            child: Text(editMode ? "Alle wählen" : ""),
            onPressed: () => {setState(() {})},
          ),
          trailing: CupertinoButton(
            padding: const EdgeInsets.all(0),
            child: Text(editMode ? "Fertig" : "Bearbeiten"),
            onPressed: () => {
              setState(() {
                editMode = !editMode;
                selectedItems = [];
              })
            },
          ),
          largeTitle: const Text('Bibliothek'),
          border: Border(
              bottom: BorderSide(
            width: 1,
            color: showNavBorder ? Colors.grey.shade300 : Colors.transparent,
          )),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Material(
                  type: MaterialType.transparency,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          decoration: const BoxDecoration(
                              border: Border.symmetric(
                                  horizontal:
                                      BorderSide(color: Colors.black12))),
                          child: ListTile(
                            minVerticalPadding: 0.0,
                            contentPadding: const EdgeInsets.all(0),
                            onTap: () => {},
                            leading: const Icon(
                              CupertinoIcons.text_justifyleft,
                              size: 20,
                            ),
                            title: const Text("Sammlungen"),
                            trailing: const Icon(
                              CupertinoIcons.chevron_forward,
                              size: 16,
                            ),
                          ))));
            },
            childCount: 1, // 1000 list items
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Material(
                  type: MaterialType.transparency,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "29 Bücher, 5 Reihen, 1 Hörbuch, 2 PDFs, 57 Objekte",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(height: 1, color: Colors.black12),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                const Text("SORTIEREN NACH"),
                                const SizedBox(
                                  width: 3,
                                ),
                                CustomPopupMenu(
                                  controller: _popupcontroller,
                                  arrowSize: 0.0,
                                  verticalMargin: 10.0,
                                  menuBuilder: () => GestureDetector(
                                    child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              spreadRadius: 1,
                                              blurRadius: 30,
                                              offset: const Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                sigmaX: 16.0,
                                                sigmaY: 16.0,
                                              ),
                                              child: Container(
                                                  width: 250,
                                                  decoration: BoxDecoration(
                                                      color: CupertinoTheme.of(
                                                              context)
                                                          .scaffoldBackgroundColor
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Column(
                                                    children: <Widget>[
                                                      for (var item
                                                          in sortByItems)
                                                        CustomPopupMenuItem(
                                                          title: item,
                                                          selected:
                                                              sortBy == item,
                                                          onSelect: (name) {
                                                            _popupcontroller
                                                                .hideMenu();
                                                            setState(() {
                                                              sortBy = name;
                                                            });
                                                          },
                                                        ),
                                                    ],
                                                  )),
                                            ))),
                                  ),
                                  barrierColor: Colors.transparent,
                                  pressType: PressType.singleClick,
                                  arrowColor: Colors.transparent,
                                  position: PreferredPosition.bottom,
                                  child: Row(children: [
                                    Text(sortBy.toUpperCase()),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    const Icon(CupertinoIcons.chevron_down,
                                        size: 14)
                                  ]),
                                )
                              ]),
                              CupertinoButton(
                                  padding: const EdgeInsets.all(5),
                                  color: showAsList
                                      ? Colors.black
                                      : Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(3)),
                                  minSize: 10,
                                  onPressed: () => {
                                        setState(() {
                                          showAsList = !showAsList;
                                        })
                                      },
                                  child: Icon(
                                    CupertinoIcons.list_bullet,
                                    size: 18,
                                    color: showAsList
                                        ? Colors.white
                                        : Colors.black,
                                  ))
                            ],
                          )
                        ],
                      )));
            },
            childCount: 1, // 1000 list items
          ),
        ),
        SliverVisibility(
          visible: showAsList,
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    minVerticalPadding: 0.0,
                    contentPadding: const EdgeInsets.all(0),
                    title: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Column(children: [
                          Row(
                            children: [
                              Visibility(
                                  visible: editMode,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: selectedItems.contains(index)
                                                ? Colors.black
                                                : Colors.transparent,
                                            border: Border.all(
                                                color: Colors.black45),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(99))),
                                        width: 20,
                                        height: 20,
                                        child: Visibility(
                                            visible:
                                                selectedItems.contains(index),
                                            child: const Icon(
                                              CupertinoIcons.check_mark,
                                              size: 12,
                                              color: Colors.white,
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  )),
                              Opacity(
                                  opacity: editMode
                                      ? selectedItems.contains(index)
                                          ? 1.0
                                          : 0.6
                                      : 1.0,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.8),

                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Hero(
                                        tag: "some_name" + index.toString(),
                                        createRectTween: (begin, end) {
                                          return MaterialRectCenterArcTween(
                                              begin: begin, end: end);
                                        },
                                        child: const Image(
                                            width: 50,
                                            image: NetworkImage(
                                                "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1461354651i/15839976.jpg")),
                                      ))),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Red Rising"),
                                      Text("Pierce Brown"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("10%"),
                                          CupertinoButton(
                                              minSize: 0,
                                              padding: const EdgeInsets.all(0),
                                              onPressed: () => {
                                                    showCupertinoModalBottomSheet(
                                                      expand: false,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (context) =>
                                                          const BookShareBottomSheet(),
                                                    )
                                                  },
                                              child: const Icon(
                                                CupertinoIcons.ellipsis,
                                                size: 16,
                                              ))
                                        ],
                                      )
                                    ],
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(height: 1, color: Colors.black12),
                        ])),
                    onTap: () {
                      if (editMode) {
                        setState(() {
                          if (selectedItems.contains(index)) {
                            selectedItems.remove(index);
                          } else {
                            selectedItems.add(index);
                          }
                        });
                      } else {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (BuildContext context) => BookPage(
                                      index: index,
                                    )));
                      }
                    },
                  ));
            },
            childCount: 10,
          )),
        ),
        SliverVisibility(
            visible: !showAsList,
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250.0,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: 0.65,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (BuildContext context) => BookPage(
                                      index: index,
                                    )));
                      },
                      child: Material(
                          child: Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              alignment: Alignment.center,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.7),
                                              spreadRadius: 1,
                                              blurRadius: 8,
                                              offset: const Offset(0,
                                                  8), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Hero(
                                          tag: "some_name" + index.toString(),
                                          createRectTween: (begin, end) {
                                            return MaterialRectCenterArcTween(
                                                begin: begin, end: end);
                                          },
                                          child: const Image(
                                              image: NetworkImage(
                                                  "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1461354651i/15839976.jpg")),
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "10%",
                                        ),
                                        CupertinoButton(
                                            padding: const EdgeInsets.all(0),
                                            onPressed: () => {
                                                  showCupertinoModalBottomSheet(
                                                    expand: false,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) =>
                                                        const BookShareBottomSheet(),
                                                  )
                                                },
                                            child: const Icon(
                                              CupertinoIcons.ellipsis,
                                              size: 16,
                                            ))
                                      ],
                                    )
                                  ]))));
                },
                childCount: 20,
              ),
            )),
      ],
    ));
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
        type: MaterialType.transparency,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
                decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.black12))),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  onTap: () => {},
                  leading: const Icon(
                    CupertinoIcons.text_justifyleft,
                    size: 20,
                  ),
                  title: const Text("Sammlungen"),
                  trailing: const Icon(
                    CupertinoIcons.chevron_forward,
                    size: 16,
                  ),
                ))));
  }

  @override
  double get minExtent => 0;

  @override
  double get maxExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
