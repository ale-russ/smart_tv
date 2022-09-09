import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/intentFiles/down_intent.dart';
import '../../../config/intentFiles/up_intent.dart';
import '../utilits/text.dart';
import '../view/Movies.dart';

class NavRail extends StatelessWidget {
  NavRail({
    Key? key,
    required int selectedIndex,
    required this.groupAlignment,
    this.callback,
  }) : super(key: key);

  FocusNode? _home;
  FocusNode? _search;
  FocusNode? _upcoming;
  FocusNode? _profile;

  _setFirstFocus(BuildContext context) {
    if (_home == null) {
      _home = FocusNode();
      _search = FocusNode();
      _upcoming = FocusNode();
      _profile = FocusNode();
      FocusScope.of(context).requestFocus(_home);
    }
  }

  _changeNodeFocus(BuildContext context, FocusNode focus) {
    FocusScope.of(context).requestFocus(focus);
  }

  int? _selectedIndex;
  final double groupAlignment;

  final setIndexCallback? callback;

  @override
  Widget build(BuildContext context) {
    if (_home == null) {
      _setFirstFocus(context);
    }
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        // LogicalKeySet(LogicalKeyboardKey.arrowRight): const ActivateIntent(),
        // LogicalKeySet(LogicalKeyboardKey.arrowLeft): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowUp): UpbuttonIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowDown): DownbuttonIntent(),
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 100,
        color: Colors.transparent,
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
              callback!(index);
            },
            destinations: [
              NavigationRailDestination(
                  icon: Actions(
                    actions: <Type, Action<Intent>>{
                      DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                          onInvoke: (Intent) =>
                              _changeNodeFocus(context, _search!))
                    },
                    child: Focus(
                      focusNode: _home!,
                      child: Icon(
                        Icons.home_rounded,
                        color:
                            _home!.hasFocus ? Colors.blueAccent : Colors.grey,
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
                            _changeNodeFocus(context, _upcoming!)),
                    UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                        onInvoke: (Intent) => _changeNodeFocus(context, _home!))
                  },
                  child: Focus(
                    focusNode: _search,
                    child: Icon(
                      Icons.search_rounded,
                      color:
                          _search!.hasFocus ? Colors.blueAccent : Colors.grey,
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
                            _changeNodeFocus(context, _profile!)),
                    UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                        onInvoke: (Intent) =>
                            _changeNodeFocus(context, _search!))
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
  // NavigationRailDestination navDestination(
  //     BuildContext context, FocusNode focusNode, Type type) {
  //   return NavigationRailDestination(
  //     icon: Actions(
  //       actions: <Type, Action<Intent>>{
  //         DownbuttonIntent: CallbackAction<DownbuttonIntent>(
  //             onInvoke: (Intent) => _changeNodeFocus(context, _search!))
  //       },
  //       child: Focus(
  //         focusNode: _home!,
  //         child: Icon(
  //           Icons.home_rounded,
  //           color: _home!.hasFocus ? Colors.blueAccent : Colors.grey,
  //           //size: 30,
  //         ),
  //       ),
  //     ),
  //     label: const Modified_text(
  //       text: 'Home',
  //       color: Colors.white,
  //       size: 15,
  //     ),
  //   );
  // }
}
