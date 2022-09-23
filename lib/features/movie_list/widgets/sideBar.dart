import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import '../utilits/text.dart';
import '../view/Movies.dart';

class NavRail extends StatefulWidget {
  NavRail({
    Key? key,
    required int selectedIndex,
    this.callback,
  }) : super(key: key);

  final setIndexCallback? callback;

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  FocusNode? _home;
  MoviesController controller = Get.find();

  IntentController _intentController = Get.find();

  Color homeColor = Colors.white;

  FocusNode? _search;
  Color searchColor = Colors.white;

  FocusNode? _upcoming;
  Color upComingColor = Colors.white;

  FocusNode? _favorites;
  Color favoriteColor = Colors.white;

  FocusNode? _profile;
  Color profileColor = Colors.white;

  @override
  void dispose() {
    _home!.dispose();
    _search!.dispose();
    _upcoming!.dispose();
    _profile!.dispose();
    super.dispose();
  }

  int? _selectedIndex;
  int? index;

  final selectedColor = Colors.amber;
  final unselectedColor = Colors.white;
  final labelStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      height: MediaQuery.of(context).size.height,
      width: 120,
      child: SizedBox(
        height: Get.height * 0.9,
        child: NavigationRail(
          labelType: NavigationRailLabelType.selected,
          groupAlignment: -0.5,
          backgroundColor: Colors.transparent,
          selectedLabelTextStyle: labelStyle.copyWith(color: selectedColor),
          unselectedLabelTextStyle: labelStyle.copyWith(color: unselectedColor),
          selectedIndex: _intentController.navSelectedIndex,
          minWidth: 45,
          selectedIconTheme: const IconThemeData(color: Colors.amber, size: 35),
          unselectedIconTheme:
              const IconThemeData(color: Colors.white, size: 25),
          onDestinationSelected: (int index) {
            _intentController.clickedIndex = index;
            widget.callback!(index);
          },
          leading: Container(
            margin:
                EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1
                    // bottom: 200
                    ),
            child: const Text(
              "Kabbee",
              style: TextStyle(color: Color(0XFFFFA500), fontSize: 24),
            ),
          ),
          destinations: [
            NavRailDes(
              label: "Home",
              focusNode: _intentController.sideNodes![0],
              icon: Icons.home_outlined,
            ),
            NavRailDes(
                label: "Search",
                focusNode: _intentController.sideNodes![1],
                icon: Icons.search),
            NavRailDes(
                label: "Coming soon",
                focusNode: _intentController.sideNodes![2],
                icon: Icons.movie),
            NavRailDes(
                label: "Favorites",
                focusNode: _intentController.sideNodes![3],
                icon: Icons.favorite_border),
            NavRailDes(
                label: "Profile",
                focusNode: _intentController.sideNodes![4],
                icon: Icons.person_rounded)
          ],
        ),
      ),
    );
  }

  NavigationRailDestination NavRailDes(
      {String? label, FocusNode? focusNode, IconData? icon, int? index}) {
    return NavigationRailDestination(
        icon: Focus(
          focusNode: focusNode,
          child: Container(
            width: 82,
            decoration: focusNode!.hasFocus
                ? BoxDecoration(
                    color: const Color(0XFFFFA500).withOpacity(0.1),
                    border: const Border(
                      right: BorderSide(
                        width: 2,
                        color: Color(0XFFFFA500),
                      ),
                    ),
                  )
                : null,
            child: Icon(
              icon,
              color: //homeColor
                  focusNode.hasFocus ? Colors.amber : Colors.grey,
              //size: 30,
            ),
          ),
        ),
        label: Text(
          label!,
        ));
  }
}
