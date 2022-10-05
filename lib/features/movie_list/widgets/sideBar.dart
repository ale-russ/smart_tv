import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/theme/icon_themes.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/movie_list/controller/movie_controller.dart';
import 'package:smart_tv/features/movie_list/widgets/navItems.dart';
import '../utilits/logo.dart';
import '../view/Movies.dart';

class NavRail extends StatefulWidget {
  NavRail({
    Key? key,
    required this.selectedIndex,
    this.callback,
  }) : super(key: key);

  final setIndexCallback? callback;
  final int selectedIndex;
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
    // _home!.dispose();
    // _search!.dispose();
    // _upcoming!.dispose();
    // _profile!.dispose();
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
        decoration: BoxDecoration(
          color: DarkModeColors.backgroundVariant,
        ),
        height: Get.height,
        width: 120,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Logo(),
              IconNav(
                callback: widget.callback,
              ),
              NavItem(
                icon: KabbeeIcons.profileFilled(color: Colors.grey, size: 30),
                active: false,
                index: 4,
                // title: 'Profile',
                callback: widget.callback,
                onPressed: (index) {},
              )
            ],
          ),
        ));
  }
}

// class SideBarItems extends StatefulWidget {
//   SideBarItems(
//       {Key? key, this.icon, this.label, this.index, required this.callback})
//       : super(key: key);

//   Widget? icon;
//   String? label;
//   int? index;

//   final setIndexCallback? callback;

//   @override
//   State<SideBarItems> createState() => _SideBarItemsState();
// }

// class _SideBarItemsState extends State<SideBarItems> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (() {
//         setState(() {
//           widget.callback!(widget.index!);
//         });
//         print("index is ${widget.index}");
//       }),
//       hoverColor: Colors.white12,
//       child: Container(
//         alignment: Alignment.center,
//         height: 70,
//         width: Get.width,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Container(
//               child: widget.icon,
//             ),
//             Text(
//               textAlign: TextAlign.center,
//               widget.label!,
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
