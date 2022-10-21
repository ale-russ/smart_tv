import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/theme/icon_themes.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/profile/controllers/user_controller.dart';

import '../../../config/intentFiles/button_intents.dart';
import '../../common/theme/text_themes.dart';
import '../view/Movies.dart';

class IconNav extends StatelessWidget {
  IconNav({Key? key, this.index, this.callback}) : super(key: key);

  List<bool> selected = [true, false, false, false, false];

  List<Widget> icons = [
    KabbeeIcons.home(color: Colors.grey, size: 25),
    KabbeeIcons.comingSoon(color: Colors.grey, size: 25),
    KabbeeIcons.search(color: Colors.grey, size: 25),
    KabbeeIcons.library(color: Colors.grey, size: 25),
  ];

  List<String> labels = [
    "Home".tr,
    "Comming Soon".tr,
    "Search".tr,
    "Library".tr
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 4, right: 4),
      // color: DarkModeColors.backgroundVariant,

      height: Get.height * 0.6,
      width: Get.width,
      child: ListView.builder(
        // itemExtent: 100,
        itemCount: icons.length,
        itemBuilder: (context, index) {
          return NavItem(
            icon: icons[index],
            title: labels[index],
            index: index,
            callback: callback,
            onPressed: () {},
            active: selected[index],
          );
        },
      ),
    );
  }

  final setIndexCallback? callback;
  int? index;
}

class NavItem extends StatelessWidget {
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
    required this.index,
  }) : super(key: key);

  final setIndexCallback? callback;

  IntentController _intentController = Get.find();

  GlobalController _globalController = Get.find();

  UserController _userController = Get.put(UserController());

  MoviesController _moviesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (() {
          callback!(index!);
        }),
        splashColor: DarkModeColors.backgroundVariant,
        // hoverColor: Colors.white12,
        child: FocusableActionDetector(
          shortcuts: _globalController.navigationIntents,
          actions: <Type, Action<Intent>>{
            DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                onInvoke: (intent) => moveDown(context)),
            UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                onInvoke: (intent) => moveUp(context)),
            RightbuttonIntent: CallbackAction<RightbuttonIntent>(
                onInvoke: (intent) => moveRight(context) // moveRight()
                ),
          },
          child: Obx(() {
            return Focus(
              focusNode: _moviesController.sideNodes![index!],
              child: Container(
                alignment: Alignment.center,
                decoration: _moviesController.sideNodes![index!].hasFocus
                    ? BoxDecoration(
                        color: PrimaryColorTones.mainColor.withOpacity(0.1),
                        border: const Border(
                          right: BorderSide(
                            width: 2,
                            color: Color(0XFFFFA500),
                          ),
                        ),
                      )
                    : null,
                height: 70,
                width: Get.width,
                child: index != 4
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: icon,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            title ?? "",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          )
                        ],
                      )
                    : Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(
                          bottom: 8,
                        ),
                        width: 400,
                        child: CircleAvatar(
                          radius: 30,
                          // child: Text("AR"),
                          backgroundImage: AssetImage('assets/images/lilo.jpg'),
                        ),
                      ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void moveUp(BuildContext context) {
    print("hereee i am ");
    if (_intentController.navSelectedIndex > 0) {
      FocusScope.of(context).requestFocus(
          _moviesController.sideNodes![--_intentController.navSelectedIndex]);
      //_intentController.navSelectedIndex--;
      _moviesController.sideNodes!.refresh();
      print("hereee");

      print("index $index");
    }
  }

  void moveDown(BuildContext context) {
    if (_intentController.navSelectedIndex < 4) {
      FocusScope.of(context).requestFocus(
          _moviesController.sideNodes![++_intentController.navSelectedIndex]);
      _moviesController.sideNodes!.refresh();
      //widget.index = widget.index! + 1;

    }
  }

  void moveRight(BuildContext context) {
    if (_moviesController.clickedIndex == 1) {
      FocusScope.of(context).requestFocus(_intentController.comingNodes![0]);
      _intentController.navSelectedIndex = 0;
      _intentController.comingNodes!.refresh();
      _intentController.coming = true;
      _moviesController.sideNodes!.refresh();
      print("coming");
    } else if (_moviesController.clickedIndex == 2) {
      FocusScope.of(context)
          .requestFocus(_intentController.searchOptionsNodes!.value[0]);
      print("in search ");
      _intentController.searchOptionsNodes!.refresh();
      _moviesController.sideNodes!.refresh();
    } else if (_moviesController.clickedIndex == 3) {
      FocusScope.of(context).requestFocus(_moviesController.comingNodes![0]);
      _intentController.navSelectedIndex = 0;
      _moviesController.comingNodes!.refresh();
      _intentController.coming = true;
      _moviesController.sideNodes!.refresh();
      print("trending");
    } else if (_moviesController.clickedIndex == 4) {
      FocusScope.of(context).requestFocus(_userController.profileNodes![0]);
      _intentController.navSelectedIndex = 0;
      _userController.profileNodes!.refresh();
      _moviesController.sideNodes!.refresh();
      print("profile");
    } else {
      FocusScope.of(context).requestFocus(_moviesController.posterNodes![0]);
      _moviesController.posterNodes!.refresh();
      _moviesController.sideNodes!.refresh();

      print("poster");
    }
    //print("out the trading icon ");
    _intentController.navSelectedIndex = 0;
    _intentController.trendingNodes!.refresh();
  }
}
