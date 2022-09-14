import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:smart_tv/config/intentFiles/right_intent.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';

import '../../../config/intentFiles/down_intent.dart';
import '../../../config/intentFiles/up_intent.dart';
import '../utilits/text.dart';
import '../view/Movies.dart';

class NavRail extends StatefulWidget {
  final FocusNode sideNode;
  NavRail({
    Key? key,
    required int selectedIndex,
    // required this.groupAlignment,
    this.callback,
    required this.sideNode,
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

  FocusNode? _favorites;
  Color favoriteColor = Colors.white;

  FocusNode? _profile;
  Color profileColor = Colors.white;

  _setFirstFocus(BuildContext context) {
    if (_home == null) {
      _home = FocusNode();
      _search = FocusNode();
      _upcoming = FocusNode();
      _favorites = FocusNode();
      _profile = FocusNode();
      controller.rightPage = FocusNode();

      // FocusScope.of(context).focusedChild!.unfocus();
      FocusScope.of(context).requestFocus(_home);
      setState(() {
        homeColor = Colors.blue;
        searchColor = upComingColor = profileColor = Colors.white;
      });

      print(" side bar  er ${widget.sideNode.hasFocus}");
      print(" home ${_home!.hasFocus}");
    }
  }

  @override
  void dispose() {
    _home!.dispose();
    _search!.dispose();
    _upcoming!.dispose();
    _profile!.dispose();
    super.dispose();
  }

  _changeNodeFocus(BuildContext context, FocusNode focus, String name) {
    FocusScope.of(context).requestFocus(focus);
    setState(() {});
    // print("name is $name");
    // if (name == "home") {
    //   setState(() {
    //     homeColor = Colors.blue;
    //     searchColor = upComingColor = profileColor = Colors.white;
    //   });
    // } else if (name == "search") {
    //   setState(() {
    //     searchColor = Colors.blue;
    //     homeColor = upComingColor = profileColor = Colors.white;
    //   });
    // } else if (name == "upComing") {
    //   print("this is upcomning please");
    //   setState(() {
    //     upComingColor = Colors.blue;
    //     searchColor = homeColor = profileColor = Colors.white;
    //   });
    // } else if (name == "favorites") {
    //   setState(() {
    //     favoriteColor = Colors.blue;
    //     searchColor = homeColor = profileColor = Colors.white;
    //   });
    // } else if (name == "profile") {
    //   setState(() {
    //     profileColor = Colors.blue;
    //     searchColor = upComingColor = homeColor = Colors.white;
    //   });
    // }
    // else if (name == "right page") {
    //   FocusScope.of(context).unfocus();
    //   FocusScope.of(context).requestFocus(focus);
    // }
    print("home on change ${_home!.hasFocus}");
    print("search on change ${_search!.hasFocus}");
    print("object${focus.hasFocus}");
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
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ActivateIntent(),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                widget.callback!(index);
              },
              destinations: [
                NavigationRailDestination(
                  icon: Actions(
                    actions: <Type, Action<Intent>>{
                      DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                        onInvoke: (intent) => _changeNodeFocus(
                          context,
                          _search!,
                          "search",
                        ),
                      ),
                      RightbuttonIntent: CallbackAction<RightbuttonIntent>(
                        onInvoke: (intent) {
                          _changeNodeFocus(
                            context,
                            controller.rightPage!,
                            "right page",
                          );
                          controller.borderColor = Colors.blue;
                          return null;
                        },
                      )
                    },
                    child: Focus(
                      focusNode: _home!,
                      child: Icon(
                        Icons.home_rounded,
                        color: _home!.hasFocus ? Colors.amber : Colors.grey,
                      ),
                    ),
                  ),
                  label: const ModifiedText(
                    text: 'Home',
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                NavigationRailDestination(
                  icon: actionMethod(
                      context: context,
                      node: _search,
                      upFocus: _home,
                      downFocus: _upcoming),
                  label: const ModifiedText(
                      text: 'Search', color: Colors.white, size: 15),
                ),
                NavigationRailDestination(
                  icon: Actions(
                    actions: <Type, Action<Intent>>{
                      DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                        onInvoke: (intent) => _changeNodeFocus(
                          context,
                          _favorites!,
                          "favorites",
                        ),
                      ),
                      UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                        onInvoke: (intent) => _changeNodeFocus(
                          context,
                          _search!,
                          "search",
                        ),
                      ),
                    },
                    child: Focus(
                      focusNode: _upcoming,
                      child: Icon(
                        Icons.movie,
                        color: _upcoming!.hasFocus ? Colors.amber : Colors.grey,
                      ),
                    ),
                  ),
                  label: const ModifiedText(
                      text: 'Upcoming', color: Colors.white, size: 15),
                ),
                NavigationRailDestination(
                  icon: Actions(
                    actions: <Type, Action<Intent>>{
                      UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                        onInvoke: (intent) => _changeNodeFocus(
                          context,
                          _upcoming!,
                          "upComing",
                        ),
                      ),
                      DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                        onInvoke: (intent) => _changeNodeFocus(
                          context,
                          _profile!,
                          "profile",
                        ),
                      )
                    },
                    child: Focus(
                      focusNode: _favorites,
                      child: Icon(
                        Icons.favorite_border,
                        color:
                            _favorites!.hasFocus ? Colors.amber : Colors.grey,
                      ),
                    ),
                  ),
                  label: const ModifiedText(
                    text: 'Favorites',
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                NavigationRailDestination(
                  icon: Actions(
                    actions: <Type, Action<Intent>>{
                      UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                        onInvoke: (intent) => _changeNodeFocus(
                          context,
                          _favorites!,
                          "favorites",
                        ),
                      )
                    },
                    child: Focus(
                      focusNode: _profile,
                      child: Icon(
                        Icons.person,
                        color: _profile!.hasFocus ? Colors.amber : Colors.grey,
                      ),
                    ),
                  ),
                  label: const ModifiedText(
                    text: 'Profile',
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Actions actionMethod(
      {required BuildContext? context,
      required FocusNode? node,
      FocusNode? upFocus,
      FocusNode? downFocus}) {
    return Actions(
      actions: <Type, Action<Intent>>{
        DownbuttonIntent: CallbackAction<DownbuttonIntent>(
          onInvoke: (intent) => _changeNodeFocus(
            context!,
            // _upcoming!,
            downFocus!,
            "upComing",
          ),
        ),
        UpbuttonIntent: CallbackAction<UpbuttonIntent>(
          onInvoke: (intent) => _changeNodeFocus(
            context!,
            // _home!,
            upFocus!,
            "home",
          ),
        )
      },
      child: Focus(
        // focusNode: _search,
        focusNode: node,
        child: Icon(Icons.search_rounded,
            color: _search!.hasFocus ? Colors.amber : Colors.grey),
      ),
    );
  }
}
