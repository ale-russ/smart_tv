import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:smart_tv/features/common/utility/icons.dart';
import 'package:smart_tv/features/movie_list/utilits/logo.dart';
import 'package:smart_tv/features/movie_list/widgets/navItems.dart';

class navBar extends StatefulWidget {
  const navBar({Key? key}) : super(key: key);

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 100,
      color: const Color(0x1F1F1F),
      child: Stack(
        children: [
          Logo(),
          Align(alignment: Alignment.center, child: iconNav()),
          Align(
              alignment: Alignment.bottomCenter,
              child: NavItem(
                icon: SmartTvIcons.profileFilledAsset,
                active: false,
                color: Colors.white,
                title: 'profile',
                size: 100,
                touched: (index) {},
              ))
        ],
      ),
    );
  }
}
