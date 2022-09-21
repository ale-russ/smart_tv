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

  // _setFirstFocus(BuildContext context) {
  //   if (_home == null) {
  //     _home = FocusNode();
  //     _search = FocusNode();
  //     _upcoming = FocusNode();
  //     _favorites = FocusNode();
  //     _profile = FocusNode();
  //     FocusScope.of(context).requestFocus(_home);
  //     FocusScope.of(context).requestFocus(_home);
  //     setState(() {
  //       homeColor = Colors.blue;
  //       searchColor = upComingColor = profileColor = Colors.white;
  //     });
  //   }
  // }

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
      width: 100,
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
          selectedIconTheme: const IconThemeData(color: Colors.amber, size: 45),
          unselectedIconTheme:
              const IconThemeData(color: Colors.white, size: 30),
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
              style: TextStyle(color: Colors.white),
            ),
          ),
          destinations: [
            NavRailDes(
              label: "Home",
              focusNode: _intentController.sideNodes![0],
              icon: Icons.home_rounded,
            ),
            NavRailDes(
                label: "Search",
                focusNode: _intentController.sideNodes![1],
                icon: Icons.search),
            NavRailDes(
                label: "Upcomming",
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
          // trailing: Container(
          //   margin:
          //       EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1
          //           // top: 200
          //           ),
          //   width: 50,
          //   height: 50,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(40),
          //       border: Border.all(
          //         color: Colors.grey,
          //       )),
          //   child: IconButton(
          //     icon: const Icon(
          //       Icons.person_rounded,
          //       size: 30,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       // widget.callback!(index);
          //       // Navigator.push(
          //       //   context,
          //       //   MaterialPageRoute(
          //       //     builder: (context) => ProfilePage(),
          //       //   ),
          //       // );
          //     },
          //   ),
          // ),
        ),
      ),
    );
  }

  NavigationRailDestination NavRailDes(
      {String? label, FocusNode? focusNode, IconData? icon, int? index}) {
    return NavigationRailDestination(
      icon: Focus(
        focusNode: focusNode,
        child: Icon(
          icon,
          color: focusNode!.hasFocus ? Colors.amber : Colors.grey,
        ),
      ),
      label: ModifiedText(
        text: label!,
        color: Colors.white,
        size: 15,
      ),
    );
  }
}
