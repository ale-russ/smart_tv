import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';
import 'package:smart_tv/features/common/controller/global_controller.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/theme/colors_utility.dart';
import 'package:smart_tv/features/common/theme/icon_themes.dart';
import 'package:smart_tv/features/common/theme/text_themes.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/movie_list/controller/landing_controller.dart';
import 'package:smart_tv/features/profile/controllers/user_controller.dart';

import '../../../config/intentFiles/button_intents.dart';
import '../../movie_list/controller/movie_controller.dart';

class ProfilePage extends GetView {
  ProfilePage({Key? key}) : super(key: key);

  //MoviesController _moviesController = Get.find();

  IntentController _intentController = Get.find();

  UserController _userController = Get.put(UserController());

  GlobalController _globalController = Get.find();

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      backgroundColor: DarkModeColors.backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          height: Get.height * 0.9,
          width: Get.width * 0.7,
          decoration: BoxDecoration(
            color: DarkModeColors.backgroundVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          child: FocusableActionDetector(
            shortcuts: _globalController.navigationIntents,
            actions: <Type, Action<Intent>>{
              DownbuttonIntent:
                  CallbackAction<DownbuttonIntent>(onInvoke: (intent) {
                if (_intentController.profileIndex <
                    _intentController.profileNodes!.length - 1) {
                  FocusScope.of(context).requestFocus(_intentController
                      .profileNodes![++_intentController.profileIndex]);
                  _intentController.profileNodes!.refresh();
                }
              }),
              LeftbuttonIntent:
                  CallbackAction<LeftbuttonIntent>(onInvoke: (intent) {
                FocusScope.of(context)
                    .requestFocus(_intentController.sideNodes![0]);
                _intentController.profileNodes!.refresh();
                _intentController.sideNodes!.refresh();

                //moveLeft(context);
                //moveLeft(context);
              }),
              UpbuttonIntent:
                  CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
                if (_intentController.profileIndex > 0) {
                  FocusScope.of(context).requestFocus(_intentController
                      .profileNodes![--_intentController.profileIndex]);
                  _intentController.profileNodes!.refresh();
                  //profileIndex--;
                  // favPageScrollController.animateTo(favPageScrollController.offset - 200,
                  //     duration: Duration(microseconds: 50), curve: Curves.ease);
                }
                //moveRight(context);
                // moveRight(context);
              })
            },
            child: SingleChildScrollView(
              child: Form(
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileAvatar(
                        node: _userController.profileNodes![0],
                      ),
                      ProfileTile(
                        name: "Alem",
                        label: "First Name",
                        node: _userController.profileNodes![1],
                        widget:
                            KabbeeIcons.profile(color: Colors.grey, size: 25),
                      ),
                      ProfileTile(
                        name: "Russom",
                        label: "Last Name",
                        node: _userController.profileNodes![2],
                        widget:
                            KabbeeIcons.profile(color: Colors.grey, size: 25),
                      ),
                      ProfileTile(
                        name: "Male",
                        label: "Gender",
                        node: _userController.profileNodes![3],
                        widget:
                            KabbeeIcons.gender(color: Colors.grey, size: 25),
                      ),
                      ProfileTile(
                        name: "September 29 2022",
                        label: "Date of Birth",
                        node: _userController.profileNodes![4],
                        widget:
                            KabbeeIcons.profile(color: Colors.grey, size: 25),
                      ),
                      ProfileTile(
                        name: "Ethiopia",
                        label: "Country",
                        node: _userController.profileNodes![5],
                        widget: KabbeeIcons.web(color: Colors.grey, size: 25),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 60,
                        width: 400,
                        child: TextButton(
                            focusNode: _userController.profileNodes![6],
                            style: ElevatedButton.styleFrom(
                              primary: DarkModeColors.surfaceColor,
                            ),
                            onPressed: () {
                              print("pressed logout button");
                              _globalController.logOutUser(context: context);
                            },
                            child: const Center(
                              child: KabbeeText.headline5(
                                "Log out",
                                customStyle: TextStyle(color: Colors.white),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  ProfileTile({Key? key, this.name, this.label, this.widget, this.node})
      : super(key: key);

  String? name;
  String? label;
  dynamic node;

  Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Focus(
        focusNode: node,
        child: Container(
          margin: EdgeInsets.only(
            top: 8,
          ),
          decoration: BoxDecoration(
              color: DarkModeColors.surfaceColor,
              borderRadius: BorderRadius.circular(4),
              border: node.hasFocus
                  ? Border.all(color: PrimaryColorTones.mainColor)
                  : null),
          width: 400,
          height: 50,
          alignment: Alignment.center,
          child: ListTile(
            dense: true,
            leading: widget,
            subtitle: Container(
              margin: EdgeInsets.only(bottom: 8, top: 2),
              child: KabbeeText.subtitle1(
                name!,
                customStyle: TextStyle(color: Colors.white),
              ),
            ),
            title: Container(
              margin: EdgeInsets.only(top: 6),
              child: KabbeeText.subtitle2(label!,
                  customStyle: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  ProfileAvatar({this.node, super.key});
  dynamic node;
  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: node,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 8,
        ),
        decoration: BoxDecoration(
            color: DarkModeColors.surfaceColor,
            borderRadius: BorderRadius.circular(4),
            border: node.hasFocus
                ? Border.all(color: PrimaryColorTones.mainColor)
                : null),
        width: 400,
        height: 70,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).backgroundColor,
            child: Text("AR"),
          ),
          title: KabbeeText.subtitle1(
            "Alem Russom",
            customStyle: TextStyle(color: Colors.white, fontSize: 16),
          ),
          subtitle: KabbeeText.subtitle2("alem@gmail.com",
              customStyle: TextStyle(color: Colors.grey, fontSize: 14)),
        ),
      ),
    );
  }
}
