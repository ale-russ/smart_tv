import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
import 'package:smart_tv/features/movie_list/controller/landing_controller.dart';
import 'package:smart_tv/features/profile/controllers/user_controller.dart';

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
  @override
  void initState() {
    for (var i = 0; i < 4; i++) {
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
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.5,
          width: 500,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
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
                  ProfileTextFields(
                    focusNode: _intentController.profileNodes![0],
                    textController: _firstNameController,
                    label: "Alem",
                  ),
                  ProfileTextFields(
                    focusNode: _intentController.profileNodes![1],
                    textController: _lastNameController,
                    label: "Russom",
                  ),
                  ProfileTextFields(
                    focusNode: _intentController.profileNodes![2],
                    textController: _sexController,
                    label: "Male",
                  ),
                  ProfileTextFields(
                    focusNode: _intentController.profileNodes![3],
                    textController: _countryController,
                    label: "Ethiopia",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTextFields extends StatelessWidget {
  const ProfileTextFields({
    Key? key,
    required this.textController,
    required this.label,
    required this.focusNode,
  }) : super(key: key);

  final TextEditingController textController;
  final String? label;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: focusNode.hasFocus
                ? Border.all(width: 2.0, color: Colors.amber)
                : null),
        child: SizedBox(
          height: 30,
          width: 300,
          child: TextFormField(
            initialValue: label,
            // controller: textController,

            decoration: InputDecoration(
              focusColor: Colors.amber,
              filled: true,
              fillColor: Colors.grey.withOpacity(0.9),
              // label: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
