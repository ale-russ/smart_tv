import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/theme/icon_themes.dart';
import 'package:smart_tv/features/common/theme/themes.dart';

import '../view/Movies.dart';

class IconNav extends StatefulWidget {
  IconNav({Key? key, this.index, this.callback}) : super(key: key);

  @override
  State<IconNav> createState() => _IconNavState();
  final setIndexCallback? callback;
  int? index;
}

class _IconNavState extends State<IconNav> {
  List<bool> selected = [true, false, false, false, false];

  List<Widget> icons = [
    KabbeeIcons.home(color: Colors.grey, size: 30),
    KabbeeIcons.comingSoon(color: Colors.grey, size: 30),
    KabbeeIcons.search(color: Colors.grey, size: 30),
    KabbeeIcons.library(color: Colors.grey, size: 30),
  ];

  List<String> labels = ["Home", "Comming Soon", "Search", "Library"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 4, right: 4),
      // color: DarkModeColors.backgroundVariant,

      height: Get.height * 0.6,
      width: Get.width,
      child: ListView.builder(
        itemExtent: 100,
        itemCount: icons.length,
        itemBuilder: (context, index) {
          print("navItem is $index");
          return NavItem(
            icon: icons[index],
            title: labels[index],
            index: index,
            callback: widget.callback,
            onPressed: () {
              setState(() {});
            },
            active: selected[0],
          );
        },
      ),
    );
  }
}

class NavItem extends StatefulWidget {
  final Widget icon;
  final Function onPressed;
  final bool active;
  String? title;
  int? index;

  NavItem({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.active,
    this.title,
    this.callback,
    this.index,
  }) : super(key: key);

  final setIndexCallback? callback;

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (() {
          widget.callback!(widget.index!);
        }),
        splashColor: DarkModeColors.backgroundVariant,
        // hoverColor: Colors.white12,
        child: Container(
          alignment: Alignment.center,
          height: 70,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: widget.icon,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.center,
                widget.title ?? "",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
