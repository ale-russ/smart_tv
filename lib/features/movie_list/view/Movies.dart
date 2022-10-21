import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/theme/themes.dart';

import 'package:smart_tv/features/movie_list/controller/landing_controller.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
// import 'package:smart_tv/features/models/movies_model.dart';
import 'package:smart_tv/features/movie_list/utilits/text.dart';
import 'package:smart_tv/features/movie_list/widgets/Movie_card.dart';
import 'package:smart_tv/features/movie_list/widgets/library.dart';
import 'package:smart_tv/features/movie_list/widgets/movies_tile.dart';

import 'package:smart_tv/features/movie_list/widgets/toprated.dart';
import 'package:smart_tv/features/movie_list/widgets/tv.dart';
import 'package:smart_tv/features/search/search.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../../config/intentFiles/button_intents.dart';

import '../../common/controller/intent_controllers.dart';
import '../../profile/screen/profile_page.dart';
import '../../search/searchPage.dart';
import '../widgets/sideBar.dart';
import '../widgets/trending.dart';
import '../controller/movie_controller.dart';

class MoviesPage extends GetView<MoviesController> {
  MoviesPage({Key? key, this.user});
  GlobalController _globalController = Get.put(GlobalController());
  MoviesController controller = Get.put(MoviesController());
  final IntentController _controller = Get.put(IntentController());

  final navigatorKey = GlobalKey<NavigatorState>();

  bool hasData = false;
  RxBool data = false.obs;

  GoogleSignInAccount? user;

  List<Widget> pages = [];

  RxInt _selectedIndex = 0.obs;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = 0;

  @override
  Widget build(BuildContext context) {
    controller.loadmovies().then((value) {
      if (controller.sideNodes!.isEmpty) {
        controller.initializeFocusNodes().then((value) => FocusScope.of(context)
            .requestFocus(controller.sideNodes!.value[0]));
        controller.sideNodes!.refresh();
      }
    });
    // if (user != null) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        List<Widget> pages = [
          Movies(
            trendingmovies: controller.trendingmovies,
            topratedmovies: controller.topratedmovies,
            tv: controller.tv,
          ),
          ComingSoon(
            movie: controller.trendingmovies,
          ),
          SearchPage(number: 0),
          Library(),
          ProfilePage(),
        ];
        return !_globalController.initialised.value
            ? Center(
                child: CircularProgressIndicator(
                color: PrimaryColorTones.mainColor,
              ))
            : Row(
                children: [
                  Container(
                    // color: DarkModeColors.backgroundVariant,
                    child: Center(
                      child: SideBar(
                          selectedIndex: _selectedIndex.value,
                          callback: (index) => controller.clickedIndex.value =
                              _selectedIndex.value = index),
                    ),
                    height: double.infinity,
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: pages[_selectedIndex.value],
                  ),
                ],
              );
      }),
    );
  }
}

typedef void setIndexCallback(int index);

class Movies extends StatelessWidget {
  Movies({
    Key? key,
    required this.trendingmovies,
    required this.topratedmovies,
    required this.tv,
    this.focusNode,
  }) : super(key: key);

  final List trendingmovies;
  final List topratedmovies;
  final List tv;
  final FocusNode? focusNode;

  final IntentController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: ListView(
        controller: _controller.homePageScrollController,
        children: [
          Movie_card(),
          TrendingMovies(
            trending: trendingmovies,
          ),
          TopRated(
            toprated: topratedmovies,
          ),
          TV(tv: tv),
        ],
      ),
    );
  }
}
