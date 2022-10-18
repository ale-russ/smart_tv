import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:smart_tv/features/common/theme/icon_themes.dart';
import 'package:smart_tv/features/common/utility/icons.dart';
import 'package:smart_tv/features/movie_list/utilits/logo.dart';
import 'package:smart_tv/features/movie_list/widgets/navItems.dart';

import '../../common/theme/themes.dart';

class navBar extends StatefulWidget {
  const navBar({Key? key}) : super(key: key);

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: DarkModeColors.backgroundVariant,
      ),
      height: MediaQuery.of(context).size.height,
      width: 100,
      //  color: const Color(0x1F1F1F),
      child: Stack(
        children: [
          Padding(padding: EdgeInsets.only(left: 15), child: Logo()),
          Align(alignment: Alignment.center, child: IconNav()),
          Align(
              alignment: Alignment.bottomCenter,
              child: NavItem(
                index: 0,
                callback: ((index) {}),
                icon: KabbeeIcons.profile(color: Colors.grey, size: 25),
                active: false,
                title: 'profile',
                onPressed: (index) {},
              ))
        ],
      ),
    );
  }
}
