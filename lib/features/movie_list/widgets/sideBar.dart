import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_tv/config/intentFiles/right_intent.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';

import '../../../config/intentFiles/down_intent.dart';
import '../../../config/intentFiles/up_intent.dart';
import '../utilits/text.dart';
import '../view/Movies.dart';

class NavRail extends StatefulWidget {
  //final FocusNode sideNode;
  NavRail({
    Key? key,
    required int selectedIndex,
    // required this.groupAlignment,
    this.callback,
    // required this.sideNode,
  }) : super(key: key);

  // final double groupAlignment;

  final setIndexCallback? callback;

  // IconData _selectedIcon = Icons.home;

  // FocusNode? _home = FocusNode();
  // FocusNode? _searchNode;
  // FocusNode? _movies;
  // FocusNode? _search;
  // FocusNode? _profile;

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  FocusNode? _home;
  MoviesController controller = Get.find();
  Color homeColor = Colors.white;

  FocusNode? _search;
  Color searchColor = Colors.white;

  FocusNode? _upcoming;
  Color upComingColor = Colors.white;

  FocusNode? _profile;
  Color profileColor = Colors.white;

  _setFirstFocus(BuildContext context) {
    if (_home == null) {
      _home = FocusNode();
      _search = FocusNode();
      _upcoming = FocusNode();
      _profile = FocusNode();
      //controller.rightPage = FocusNode();
      FocusScope.of(context).requestFocus(_home);
      // print(FocusScope.of(context).focusedChild!.hasFocus);
      // print(_home!.hasFocus);
      // print(widget.sideNode.hasFocus);
      // print(" side bar  er " + widget.sideNode.hasFocus.toString());
      // FocusScope.of(context).focusedChild!.unfocus();
      FocusScope.of(context).requestFocus(_home);
      setState(() {
        homeColor = Colors.blue;
        searchColor = upComingColor = profileColor = Colors.white;
      });

      // print(FocusScope.of(context).focusedChild);
      // print(_home);
      // print(widget.sideNode);

      print(" home " + _home!.hasFocus.toString());
    }
  }

  void dispose() {
    _home!.dispose();
    _search!.dispose();
    _upcoming!.dispose();
    _profile!.dispose();
  }

  _changeNodeFocus(BuildContext context, FocusNode focus, String name) {
    FocusScope.of(context).requestFocus(focus);
    print(name);
    if (name == "home") {
      setState(() {
        homeColor = Colors.blue;
        searchColor = upComingColor = profileColor = Colors.white;
      });
    } else if (name == "search") {
      setState(() {
        searchColor = Colors.blue;
        homeColor = upComingColor = profileColor = Colors.white;
      });
    } else if (name == "upComing") {
      print("this is upcomning please");
      setState(() {
        upComingColor = Colors.blue;
        searchColor = homeColor = profileColor = Colors.white;
      });
    } else if (name == "profile") {
      setState(() {
        profileColor = Colors.blue;
        searchColor = upComingColor = homeColor = Colors.white;
      });
    } else if (name == "right page") {
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(focus);
    }
    print("home on change " + _home!.hasFocus.toString());
    print("search on change " + _search!.hasFocus.toString());
    print("object" + focus.hasFocus.toString());
  }

  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    // if (controller.sideNode!.hasFocus) {
    //   _setFirstFocus(context);
    // } else {
    //   print(" please ${controller.sideNode!.hasFocus}");
    // }
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: false //widget.sideNode.hasFocus
              ? Border.all(color: Colors.blue)
              : Border.all(color: Colors.black)),
      height: MediaQuery.of(context).size.height,
      width: 100,
      // color: Colors.transparent,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        NavigationRail(
          labelType: NavigationRailLabelType.all,
          groupAlignment: -0.5,
          backgroundColor: Colors.transparent,
          // selectedLabelTextStyle: labelStyle.copyWith(color: selectedColor),
          // unselectedLabelTextStyle:
          //       labelStyle.copyWith(color: unselectedColor),
          selectedIndex: controller.navSelectedIndex,
          minWidth: 45,
          selectedIconTheme: const IconThemeData(color: Colors.amber, size: 10),
          unselectedIconTheme:
              const IconThemeData(color: Colors.white, size: 30),
          // groupAlignment: groupAlignment,
          onDestinationSelected: (int index) {
            // _selectedIndex = index;
            widget.callback!(index);
          },
          destinations: [
            NavigationRailDestination(
                icon: Focus(
                  focusNode: controller.sideNodes![0],
                  child: Icon(
                    Icons.home_rounded,
                    color: //homeColor
                        controller.sideNodes![0].hasFocus
                            ? Colors.blueAccent
                            : Colors.grey,
                    //size: 30,
                  ),
                ),
                label: const Modified_text(
                    text: 'Home', color: Colors.white, size: 15)),
            NavigationRailDestination(
              icon: Focus(
                focusNode: controller.sideNodes![1],
                child: Icon(
                  Icons.search_rounded,
                  color: //searchColor
                      controller.sideNodes![1].hasFocus
                          ? Colors.blueAccent
                          : Colors.grey,
                ),
              ),
              label: const Modified_text(
                  text: 'Search', color: Colors.white, size: 15),
            ),
            NavigationRailDestination(
              icon: Focus(
                focusNode: controller.sideNodes![2],
                child: Icon(
                  Icons.movie,
                  color: controller.sideNodes![2].hasFocus
                      ? Colors.blueAccent
                      : Colors.grey,
                ),
              ),
              label: const Modified_text(
                  text: 'Upcomming', color: Colors.white, size: 15),
            ),
            NavigationRailDestination(
              icon: Focus(
                focusNode: controller.sideNodes![3],
                child: Icon(
                  Icons.favorite_border,
                  color: controller.sideNodes![3].hasFocus
                      ? Colors.blueAccent
                      : Colors.grey,
                ),
              ),
              label: const Modified_text(
                  text: 'Favorites', color: Colors.white, size: 15),
            ),
            NavigationRailDestination(
              icon: Focus(
                  focusNode: controller.sideNodes![4],
                  child: Icon(
                    Icons.person,
                    color: controller.sideNodes![4].hasFocus
                        ? Colors.blueAccent
                        : Colors.grey,
                  )),
              label: Modified_text(
                text: 'Profile',
                color: Colors.white,
                size: 15,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
