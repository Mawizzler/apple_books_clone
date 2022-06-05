import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomPopupMenuItem extends StatelessWidget {
  final String title;
  final bool selected;
  final Function onSelect;
  const CustomPopupMenuItem(
      {Key? key,
      required this.title,
      required this.selected,
      required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          minimumSize: const Size.fromHeight(40),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          primary: Colors.grey.withOpacity(0.2),
        ),
        onPressed: () => onSelect(title),
        child: Row(children: [
          const SizedBox(
            width: 4,
          ),
          Text(
            String.fromCharCode(CupertinoIcons.check_mark.codePoint),
            style: TextStyle(
              inherit: false,
              color: selected ? Colors.black : Colors.transparent,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              fontFamily: CupertinoIcons.exclamationmark_circle.fontFamily,
              package: CupertinoIcons.exclamationmark_circle.fontPackage,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal))
        ]));
  }
}
