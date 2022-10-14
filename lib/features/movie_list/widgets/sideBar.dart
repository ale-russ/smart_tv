import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/theme/icon_themes.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/widgets/navItems.dart';
import '../utilits/logo.dart';
import '../view/Movies.dart';

class SideBar extends StatefulWidget {
  SideBar({
    Key? key,
    required this.selectedIndex,
    this.callback,
  }) : super(key: key);

  final setIndexCallback? callback;
  final int selectedIndex;
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  FocusNode? _home;
  MoviesController controller = Get.find();
  GlobalController gController = Get.find();
  IntentController _intentController = Get.find();

  @override
  void dispose() {
    super.dispose();
  }

  //int? index;

  // final selectedColor = Colors.amber;
  // final unselectedColor = Colors.white;
  // final labelStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: DarkModeColors.backgroundVariant,
        ),
        height: Get.height,
        width: 120,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Logo(),
              IconNav(
                callback: widget.callback,
              ),
              NavItem(
                icon: KabbeeIcons.profileFilled(color: Colors.grey, size: 30),
                active: false,
                index: 4,
                // title: 'Profile',
                callback: widget.callback,
                onPressed: (index) {},
              )
            ],
          ),
        ));
  }
}
