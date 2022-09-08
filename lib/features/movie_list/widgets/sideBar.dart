import 'package:flutter/material.dart';

import '../utilits/text.dart';
import '../view/Movies.dart';

class NavRail extends StatefulWidget {
  NavRail({
    Key? key,
    required int selectedIndex,
    // required this.groupAlignment,
    this.callback,
  }) : super(key: key);

  final setIndexCallback? callback;

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 100,
      color: Colors.transparent,
      child: Focus(
        child: Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            NavigationRail(
              labelType: NavigationRailLabelType.selected,
              groupAlignment: -0.5,
              backgroundColor: Colors.transparent,
              // selectedLabelTextStyle: labelStyle.copyWith(color: selectedColor),
              // unselectedLabelTextStyle:
              //       labelStyle.copyWith(color: unselectedColor),
              selectedIndex: _selectedIndex,
              minWidth: 45,
              selectedIconTheme: IconThemeData(color: Colors.amber, size: 35),
              unselectedIconTheme: IconThemeData(color: Colors.white, size: 30),
              // groupAlignment: groupAlignment,
              onDestinationSelected: (int index) {
                _selectedIndex = index;
                widget.callback!(index);
              },
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(
                      Icons.home_rounded,
                      //size: 30,
                    ),
                    label: Modified_text(
                        text: 'Home', color: Colors.white, size: 15)),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.search_rounded,
                  ),
                  label: Modified_text(
                      text: 'Search', color: Colors.white, size: 15),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.movie,
                  ),
                  label: Modified_text(
                      text: 'Upcomming', color: Colors.white, size: 15),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.favorite_border,
                  ),
                  label: Modified_text(
                      text: 'Favorite', color: Colors.white, size: 15),
                ),
                NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Modified_text(
                        text: 'Profile', color: Colors.white, size: 15))
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
