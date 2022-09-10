import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_tv/config/intentFiles/right_intent.dart';
import 'package:smart_tv/features/movie_list/view/movie_controller.dart';

import '../../../config/intentFiles/down_intent.dart';
import '../../../config/intentFiles/up_intent.dart';
import '../utilits/text.dart';
import '../view/Movies.dart';

class NavRail extends StatefulWidget {
  final FocusNode sideNode;
  NavRail({
    Key? key,
    required int selectedIndex,
    required this.groupAlignment,
    this.callback,
    required this.sideNode,
  }) : super(key: key);

  final double groupAlignment;

  final setIndexCallback? callback;

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
      controller.rightPage = FocusNode();

      // FocusScope.of(context).focusedChild!.unfocus();
      FocusScope.of(context).requestFocus(_home);
      setState(() {
        homeColor = Colors.blue;
        searchColor = upComingColor = profileColor = Colors.white;
      });

      print(" side bar  er " + widget.sideNode.hasFocus.toString());
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
      setState(() {
        upComingColor = Colors.blue;
        searchColor = homeColor = profileColor = Colors.white;
      });
    } else if (name == "profile") {
      setState(() {
        profileColor = Colors.blue;
        searchColor = upComingColor = homeColor = Colors.white;
      });
    }
    print("home on change " + _home!.hasFocus.toString());
    print("search on change " + _search!.hasFocus.toString());
    print("object" + focus.hasFocus.toString());
  }

  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (_home == null) {
      _setFirstFocus(context);
    }
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight): RightbuttonIntent(),
        // LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowUp): UpbuttonIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowDown): DownbuttonIntent(),
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: widget.sideNode.hasFocus
                ? Border.all(color: Colors.black)
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
            selectedIndex: _selectedIndex,
            minWidth: 45,
            selectedIconTheme:
                const IconThemeData(color: Colors.amber, size: 10),
            unselectedIconTheme:
                const IconThemeData(color: Colors.white, size: 30),
            // groupAlignment: groupAlignment,
            onDestinationSelected: (int index) {
              // _selectedIndex = index;
              widget.callback!(index);
            },
            destinations: [
              NavigationRailDestination(
                  icon: Actions(
                    actions: <Type, Action<Intent>>{
                      DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                          onInvoke: (Intent) =>
                              _changeNodeFocus(context, _search!, "search")),
                      RightbuttonIntent:
                          CallbackAction<RightbuttonIntent>(onInvoke: (Intent) {
                        _changeNodeFocus(
                            context, controller.rightPage!, "right page");
                        controller.borderColor = Colors.blue;
                      })
                    },
                    child: Focus(
                      focusNode: _home!,
                      child: Icon(Icons.home_rounded, color: homeColor
                          //_home!.hasFocus ? Colors.blueAccent : Colors.grey,
                          //size: 30,
                          ),
                    ),
                  ),
                  label: const Modified_text(
                      text: 'Home', color: Colors.white, size: 15)),
              NavigationRailDestination(
                icon: Actions(
                  actions: <Type, Action<Intent>>{
                    DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                        onInvoke: (Intent) =>
                            _changeNodeFocus(context, _upcoming!, "upComing")),
                    UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                        onInvoke: (Intent) =>
                            _changeNodeFocus(context, _home!, "home"))
                  },
                  child: Focus(
                    focusNode: _search,
                    child: Icon(Icons.search_rounded, color: searchColor
                        //_search!.hasFocus ? Colors.blueAccent : Colors.grey,
                        ),
                  ),
                ),
                label: const Modified_text(
                    text: 'Search', color: Colors.white, size: 15),
              ),
              NavigationRailDestination(
                icon: Actions(
                  actions: <Type, Action<Intent>>{
                    DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                        onInvoke: (Intent) =>
                            _changeNodeFocus(context, _profile!, "profile")),
                    UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                        onInvoke: (Intent) =>
                            _changeNodeFocus(context, _search!, "search"))
                  },
                  child: Focus(
                    focusNode: _upcoming,
                    child: Icon(
                      Icons.movie,
                      color:
                          _upcoming!.hasFocus ? Colors.blueAccent : Colors.grey,
                    ),
                  ),
                ),
                label: const Modified_text(
                    text: 'Upcomming', color: Colors.white, size: 15),
              ),
              NavigationRailDestination(
                icon: Focus(
                  focusNode: _profile,
                  child: Icon(
                    Icons.favorite_border,
                    color: _profile!.hasFocus ? Colors.blueAccent : Colors.grey,
                  ),
                ),
                label: const Modified_text(
                    text: 'Favorites', color: Colors.white, size: 15),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Modified_text(
                  text: 'Profile',
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
