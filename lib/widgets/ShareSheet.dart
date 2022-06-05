import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Item {
  final String title;
  final IconData? icon;

  Item(this.title, this.icon);
}

extension ListUtils<T> on List<T> {
  List<T> addItemInBetween<A extends T>(A item) => this.length == 0
      ? this
      : (this.fold([], (r, element) => [...r, element, item])..removeLast());
}

final actions = [
  Item('Kopieren', CupertinoIcons.doc_on_doc),
  Item('Buch teilen', CupertinoIcons.square_arrow_up),
];
final actions1 = [
  Item('Zur Leseliste hinzufügen', CupertinoIcons.text_badge_star),
  Item('Zur Sammlung hinzufügen...', CupertinoIcons.text_badge_plus),
  Item('Als "Gelesen" markieren', CupertinoIcons.check_mark_circled),
  Item('Entfernen', CupertinoIcons.trash),
  Item('Im Store anzeigen', CupertinoIcons.bag),
  Item('Bewertungen und Rezensionen', CupertinoIcons.quote_bubble),
  Item('Mehr solcher Vorschläge', CupertinoIcons.hand_thumbsup),
  Item('Weniger solcher Vorschläge', CupertinoIcons.hand_thumbsdown),
];

class BookShareBottomSheet extends StatelessWidget {
  const BookShareBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
            color: Colors.transparent,
            child: Scaffold(
              backgroundColor: CupertinoTheme.of(context)
                  .scaffoldBackgroundColor
                  .withOpacity(0.9),
              extendBodyBehindAppBar: false,
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(65.0),
                  child: Container(
                      height: 65,
                      child: CupertinoNavigationBar(
                          padding: const EdgeInsetsDirectional.only(
                              start: 12, end: 18),
                          leading: const Text(""),
                          middle: Row(children: [
                            const Image(
                                height: 35,
                                image: NetworkImage(
                                    "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1461354651i/15839976.jpg")),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text('Red Rising',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                                SizedBox(
                                  height: 1,
                                ),
                                Text('Author Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87,
                                        fontSize: 12))
                              ],
                            ),
                          ]),
                          trailing: Container(
                            alignment: Alignment.topRight,
                            width: 25,
                            height: 25,
                            child: CupertinoButton(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(99)),
                                color: Colors.grey.shade400,
                                padding: const EdgeInsets.all(0),
                                onPressed: () => {Navigator.of(context).pop()},
                                child: const Icon(
                                  CupertinoIcons.clear,
                                  size: 16,
                                  color: Colors.black54,
                                )),
                          )))),
              body: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                controller: ModalScrollController.of(context),
                slivers: <Widget>[
                  SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 18),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate.fixed(
                              List<Widget>.from(
                                  actions.asMap().entries.map((entry) {
                        int idx = entry.key;
                        Item action = entry.value;
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(idx == 0 ? 10.0 : 0.0),
                                  bottomRight: Radius.circular(
                                      idx == (actions.length - 1) ? 10.0 : 0.0),
                                  topLeft:
                                      Radius.circular(idx == 0 ? 10.0 : 0.0),
                                  bottomLeft: Radius.circular(
                                      idx == (actions.length - 1)
                                          ? 10.0
                                          : 0.0)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  action.title,
                                  style: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle,
                                ),
                                Icon(
                                  action.icon,
                                  size: 20,
                                ),
                              ],
                            ));
                      })).addItemInBetween(const Divider(
                        height: 1,
                      ))))),
                  SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 0),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate.fixed(
                              List<Widget>.from(
                                  actions1.asMap().entries.map((entry) {
                        int idx = entry.key;
                        Item action = entry.value;
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(idx == 0 ? 10.0 : 0.0),
                                  bottomRight: Radius.circular(
                                      idx == (actions1.length - 1)
                                          ? 10.0
                                          : 0.0),
                                  topLeft:
                                      Radius.circular(idx == 0 ? 10.0 : 0.0),
                                  bottomLeft: Radius.circular(
                                      idx == (actions1.length - 1)
                                          ? 10.0
                                          : 0.0)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  action.title,
                                  style: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle,
                                ),
                                Icon(
                                  action.icon,
                                  size: 20,
                                ),
                              ],
                            ));
                      })).addItemInBetween(const Divider(
                        height: 1,
                      ))))),
                  const SliverSafeArea(
                    top: false,
                    sliver: SliverPadding(
                        padding: EdgeInsets.only(
                      bottom: 20,
                    )),
                  )
                ],
              ),
            )));
  }
}
