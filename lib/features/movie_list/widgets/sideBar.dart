import 'package:flutter/material.dart';

import '../utilits/text.dart';
import '../view/Movies.dart';

class NavRail extends StatelessWidget {
  NavRail({
    Key? key,
    required int selectedIndex,
    required this.groupAlignment,
    this.callback,
  }) : super(key: key);

  int? _selectedIndex;
  final double groupAlignment;

  final setIndexCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 100,
      color: Colors.transparent,
      child: Container(
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
            selectedIconTheme: IconThemeData(color: Colors.amber, size: 10),
            unselectedIconTheme: IconThemeData(color: Colors.white, size: 30),
            // groupAlignment: groupAlignment,
            onDestinationSelected: (int index) {
              _selectedIndex = index;
              callback!(index);
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
                    text: 'Profile', color: Colors.white, size: 15),
              ),
              NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Modified_text(
                      text: 'Profile', color: Colors.white, size: 15))
            ],
          ),
        ]),
      ),
    );
  }
}
