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

class SideBar extends StatelessWidget {
  SideBar({
    Key? key,
    required this.selectedIndex,
    this.callback,
  }) : super(key: key);

  final setIndexCallback? callback;
  final int selectedIndex;

  MoviesController controller = Get.find();

  GlobalController gController = Get.find();

  //IntentController _intentController = Get.find();

  //int? index;
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
                callback: callback,
              ),
              NavItem(
                icon: KabbeeIcons.profileFilled(color: Colors.grey, size: 30),
                active: false,
                index: 4,
                // title: 'Profile',
                callback: callback,
                onPressed: (index) {},
              )
            ],
          ),
        ));
  }
}
