import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/theme/icon_themes.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/models/movies_model.dart';
import 'package:smart_tv/features/profile/screen/profile_page.dart';

import '../../../config/intentFiles/button_intents.dart';
import '../../common/theme/text_themes.dart';
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
            callback: widget.callback,
            onPressed: () {
              setState(() {});
            },
            active: selected[index],
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
    required this.index,
  }) : super(key: key);

  final setIndexCallback? callback;

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  IntentController _intentController = Get.find();
  GlobalController _globalController = Get.find();

  @override
  void initState() {
    for (var i = 0; i < 8; i++) {
      _intentController.profileNodes!.add(FocusNode(debugLabel: "profile $i"));
      print(_intentController.profileNodes![i]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Obx(
          (() => InkWell(
                onTap: (() {
                  widget.callback!(widget.index!);
                }),
                splashColor: DarkModeColors.backgroundVariant,
                // hoverColor: Colors.white12,
                child: FocusableActionDetector(
                  shortcuts: _globalController.navigationIntents,
                  actions: <Type, Action<Intent>>{
                    DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                        onInvoke: (intent) => moveDown()),
                    UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                        onInvoke: (intent) => moveUp()),
                    RightbuttonIntent: CallbackAction<RightbuttonIntent>(
                        onInvoke: (intent) => moveRight() // moveRight()
                        ),
                  },
                  child: Focus(
                    focusNode: _intentController.sideNodes![widget.index!],
                    child: Container(
                      alignment: Alignment.center,
                      decoration: _intentController
                              .sideNodes![widget.index!].hasFocus
                          ? BoxDecoration(
                              color:
                                  PrimaryColorTones.mainColor.withOpacity(0.1),
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
                      child: widget.index != 4
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: widget.icon,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    widget.title ?? "",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
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
                                  backgroundImage:
                                      AssetImage('assets/images/lilo.jpg')),
                            ),
                    ),
                    // }),
                  ),
                ),
              )),
        ));
  }

  void moveUp() {
    print("hereee i am ");
    if (_intentController.navSelectedIndex > 0) {
      FocusScope.of(context).requestFocus(
          _intentController.sideNodes![--_intentController.navSelectedIndex]);
      //_intentController.navSelectedIndex--;
      _intentController.sideNodes!.refresh();
      print("hereee");
      //widget.index = widget.index! - 1;
      setState(() {});
      print("index ${widget.index}");
    }
  }

  void moveDown() {
    if (_intentController.navSelectedIndex < 4) {
      FocusScope.of(context).requestFocus(
          _intentController.sideNodes![++_intentController.navSelectedIndex]);
      _intentController.sideNodes!.refresh();
      //widget.index = widget.index! + 1;
      setState(() {});
    }
  }

  void moveRight() {
    if (_intentController.clickedIndex == 2) {
      FocusScope.of(context)
          .requestFocus(_intentController.searchOptionsNodes!.value[0]);
      print("in search ");
      _intentController.searchOptionsNodes!.refresh();
    } else if (_intentController.clickedIndex == 1) {
      FocusScope.of(context).requestFocus(_intentController.comingNodes![0]);
      _intentController.navSelectedIndex = 0;
      _intentController.comingNodes!.refresh();
      _intentController.coming = true;
      print("coming");
    } else if (_intentController.clickedIndex == 3) {
      FocusScope.of(context).requestFocus(_intentController.comingNodes![0]);
      _intentController.navSelectedIndex = 0;
      _intentController.comingNodes!.refresh();
      _intentController.coming = true;
      print("trending");
    } else if (_intentController.clickedIndex == 4) {
      FocusScope.of(context).requestFocus(_intentController.profileNodes![0]);
      _intentController.profileNodes!.refresh();
      print("profile");
    } else {
      //print(_intentController.posterNodes![0].hasFocus);
      //Get.focusScope!.requestFocus(_intentController.trendingNodes![0]);
      FocusScope.of(context).requestFocus(_intentController.posterNodes![0]);
      _intentController.posterNodes!.refresh();
      print("poster");
    }
    //print("out the trading icon ");
    _intentController.navSelectedIndex = 0;
    _intentController.trendingNodes!.refresh();
    setState(() {});
  }
}
