import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/common/theme/colors_utility.dart';
import 'package:smart_tv/features/common/theme/icon_themes.dart';
import 'package:smart_tv/features/common/theme/text_themes.dart';
import 'package:smart_tv/features/common/theme/themes.dart';
import 'package:smart_tv/features/movie_list/controller/landing_controller.dart';
import 'package:smart_tv/features/profile/controllers/user_controller.dart';

import '../../../config/intentFiles/button_intents.dart';
import '../../movie_list/controller/movie_controller.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  FocusNode? _firstNameNode = FocusNode();
  MoviesController controller = Get.find();
  IntentController _intentController = Get.find();
  UserController _userController = Get.put(UserController());

  @override
  void initState() {
    for (var i = 0; i < 6; i++) {
      _intentController.profileNodes!.add(FocusNode());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GetPlatform.isDesktop || GetPlatform.isWeb
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : const SizedBox.shrink()),
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Focus(
          focusNode: _intentController.profileNodes![0],
          child: Container(
            alignment: Alignment.center,
            height: Get.height * 0.9,
            width: Get.width * 0.8,
            decoration: BoxDecoration(
              color: DarkModeColors.backgroundVariant,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white60,
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Actions(actions: <Type, Action<Intent>>{
                      DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                          onInvoke: (intent) => FocusScope.of(context)
                              .nextFocus() //_changeNodeFocus(context, "Down")
                          )
                    }, child: ProfileAvatar()),
                    Actions(
                        actions: <Type, Action<Intent>>{
                          DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                              onInvoke: (intent) => FocusScope.of(context)
                                  .nextFocus() //_changeNodeFocus(context, "Down")
                              )
                        },
                        child: ProfileTile(
                          name: "Alem",
                          label: "First Name",
                          widget:
                              KabbeeIcons.profile(color: Colors.grey, size: 40),
                        )),
                    Actions(
                        actions: <Type, Action<Intent>>{
                          DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                              onInvoke: (intent) {
                            print('local action');
                            FocusScope.of(context).nextFocus();
                          } //_changeNodeFocus(context, "Down")
                              ),
                          UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                              onInvoke: (intent) {
                            print('local action up');
                            FocusScope.of(context).previousFocus();
                          } //_changeNodeFocus(context, "Down")
                              )
                        },
                        child: ProfileTile(
                          name: "Russom",
                          label: "Last Name",
                          widget:
                              KabbeeIcons.profile(color: Colors.grey, size: 40),
                        )),
                    Actions(
                        actions: <Type, Action<Intent>>{
                          DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                              onInvoke: (intent) {
                            print('local action');
                            FocusScope.of(context).nextFocus();
                          } //_changeNodeFocus(context, "Down")
                              ),
                          UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                              onInvoke: (intent) {
                            print('local action up');
                            FocusScope.of(context).previousFocus();
                          } //_changeNodeFocus(context, "Down")
                              )
                        },
                        child: ProfileTile(
                          name: "Male",
                          label: "Gender",
                          widget:
                              KabbeeIcons.gender(color: Colors.grey, size: 40),
                        )),
                    Actions(
                        actions: <Type, Action<Intent>>{
                          DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                              onInvoke: (intent) {
                            print('local action down');
                            FocusScope.of(context).nextFocus();
                          } //_changeNodeFocus(context, "Down")
                              ),
                          UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                              onInvoke: (intent) {
                            print('local action up');
                            FocusScope.of(context).previousFocus();
                          } //_changeNodeFocus(context, "Down")
                              )
                        },
                        child: ProfileTile(
                          name: "September 29 2022",
                          label: "Date of Birth",
                          widget:
                              KabbeeIcons.profile(color: Colors.grey, size: 40),
                        )),
                    Actions(
                        actions: <Type, Action<Intent>>{
                          DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                              onInvoke: (intent) {
                            print('local action down');
                            FocusScope.of(context).nextFocus();
                          } //_changeNodeFocus(context, "Down")
                              ),
                          UpbuttonIntent: CallbackAction<UpbuttonIntent>(
                              onInvoke: (intent) {
                            print('local action up');
                            FocusScope.of(context).previousFocus();
                          } //_changeNodeFocus(context, "Down")
                              )
                        },
                        child: ProfileTile(
                          name: "Ethiopia",
                          label: "Country",
                          widget: KabbeeIcons.web(color: Colors.grey, size: 40),
                        )),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      height: 60,
                      width: 400,
                      child: TextButton(
                          focusNode: _intentController.profileNodes![5],
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DarkModeColors.surfaceColor,
                          ),
                          onPressed: () {},
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
    );
  }
}

class ProfileTextFields extends StatelessWidget {
  ProfileTextFields({
    Key? key,
    required this.textController,
    required this.label,
    required this.focusNode,
    this.widget,
    this.height = 60,
  }) : super(key: key);

  final TextEditingController textController;
  final String? label;
  final FocusNode focusNode;

  final Widget? widget;

  double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: height,
      width: 300,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        onEditingComplete: () {
          print("Edite complete");
          FocusScope.of(context).nextFocus();
          print(FocusManager.instance.primaryFocus);
        },
        initialValue: label,
        focusNode: focusNode,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 50),
          isDense: true,
          prefixIcon: Container(
            margin: EdgeInsets.only(right: 20, left: 10),
            child: widget,
            // child: KabbeeIcons.profile(color: Colors.white, size: 30),
          ),
          focusColor: Colors.amber,
          filled: true,
          fillColor: DarkModeColors.surfaceColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  ProfileTile({
    Key? key,
    this.name,
    this.label,
    this.widget,
  }) : super(key: key);

  String? name;
  String? label;

  Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        decoration: BoxDecoration(
          color: DarkModeColors.surfaceColor,
          borderRadius: BorderRadius.circular(4),
        ),
        width: 400,
        alignment: Alignment.center,
        child: ListTile(
          leading: widget,
          subtitle: Container(
            margin: EdgeInsets.only(top: 5),
            child: KabbeeText.subtitle1(
              name!,
              customStyle: TextStyle(color: Colors.white),
            ),
          ),
          title: KabbeeText.subtitle2(label!,
              customStyle: TextStyle(color: Colors.grey, fontSize: 14)),
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: DarkModeColors.surfaceColor,
        borderRadius: BorderRadius.circular(4),
      ),
      width: 400,
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
    );
  }
}
