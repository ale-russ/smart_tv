import 'dart:ffi';

import 'package:flutter/material.dart';
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
      height: 350.0,
      child: Column(
        children: [
          NavItem(
              icon: SmartTvIcons.homeAsset,
              title: 'Home',
              size: 10,
              color: Colors.white,
              touched: () {
                setState(() {
                  // select(0);
                });
              },
              active: selected[0]),
          NavItem(
              icon: SmartTvIcons.homeAsset,
              title: 'Comming soon',
              size: 10,
              color: Colors.amber,
              touched: () {
                setState(() {
                  //select(0);
                });
              },
              active: selected[0]),
          NavItem(
              icon: SmartTvIcons.searchAsset,
              title: 'Search',
              size: 10,
              color: Colors.amber,
              touched: () {
                setState(() {
                  // select(0);
                });
              },
              active: selected[0]),
          NavItem(
              icon: SmartTvIcons.libraryAsset,
              title: 'Library',
              size: 10,
              color: Colors.amber,
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
  final String icon;
  final Function touched;
  final bool active;
  final String title;
  final Color color;
  final double size;

  NavItem(
      {Key? key,
      required this.icon,
      required this.touched,
      required this.active,
      required this.title,
      required this.color,
      required this.size})
      : super(key: key);

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
          // widget.touched();
        }),
        splashColor: Colors.white,
        hoverColor: Colors.white12,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              Container(
                height: 65.0,
                width: 80.0,
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(widget.icon)
                        // Icon(
                        //   widget.icon,
                        //   color: widget.active ? Colors.white54 : Colors.white54,
                        //   size: 19.0,
                        // ),
                        )
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
