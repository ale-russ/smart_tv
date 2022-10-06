import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/theme/icon_themes.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/common/utility/icons.dart';

import '../utilits/text.dart';

class iconNav extends StatefulWidget {
  @override
  State<iconNav> createState() => _iconNavState();
}

class _iconNavState extends State<iconNav> {
  List<bool> selected = [true, false, false, false, false];

  // void select(int n) {
  //   for (int i = 0; i < 5; i++) {
  //     if (i != n) {
  //       selected[i] = false;
  //     } else {
  //       selected[i] = true;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.6,
      child: Column(
        children: [
          NavItem(
              icon: KabbeeIcons.home(color: Colors.grey, size: 25),
              //icon: KabbeeIconshome(color: Colors.grey, size: 16),
              title: 'Home',
              touched: () {
                setState(() {
                  // select(0);
                });
              },
              active: selected[0]),
          NavItem(
              icon: KabbeeIcons.search(color: Colors.grey, size: 25),
              title: 'Comming soon',
              touched: () {
                setState(() {
                  //select(0);
                });
              },
              active: selected[0]),
          NavItem(
              icon: KabbeeIcons.comingSoon(color: Colors.grey, size: 25),
              title: 'Search',
              touched: () {
                setState(() {
                  // select(0);
                });
              },
              active: selected[0]),
          NavItem(
              icon: KabbeeIcons.library(color: Colors.grey, size: 25),
              title: 'Library',
              touched: () {
                setState(() {
                  //  select(0);
                });
              },
              active: selected[0]),
          // SizedBox(
          //   height: 20,
          // ),
          // NavItem(
          //     icon: Icons.library_add,
          //     touched: () {
          //       setState(() {
          //         select(0);
          //       });
          //     },
          //     active: selected[0]),
        ],
      ),
    );
  }
}

class NavItem extends StatefulWidget {
  final Widget icon;
  final Function touched;
  final bool active;
  final String title;

  NavItem({
    Key? key,
    required this.icon,
    required this.touched,
    required this.active,
    required this.title,
  }) : super(key: key);

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
          widget.touched();
        }),
        splashColor: Colors.amber,
        hoverColor: Colors.amber,
        child: Container(
          // color: DarkModeColors.backgroundVariant,
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              Container(
                //  color: DarkModeColors.backgroundVariant,
                height: 65.0,
                width: 80.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    widget.icon,
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
