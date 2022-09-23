import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';
import 'package:smart_tv/features/common/controller/intent_controllers.dart';
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
    // _firstNameController.text = _userController.user!.firtName!;
    // _lastNameController.text = _userController.user!.lastName!;
    // _sexController.text = _userController.user!.sex!;
    // _countryController.text = _userController.user!.country!;
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
        child: Focus(
          focusNode: _intentController.profileNodes![0],
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
                    Actions(
                      actions: <Type, Action<Intent>>{
                        DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                            onInvoke: (intent) => FocusScope.of(context)
                                .nextFocus() //_changeNodeFocus(context, "Down")
                            )
                      },
                      child: ProfileTextFields(
                          focusNode: _intentController.profileNodes![1],
                          textController: _firstNameController,
                          label: "Mohammed" // _userController.user!.firtName,
                          ),
                    ),
                    Actions(
                      actions: <Type, Action<Intent>>{
                        DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                            onInvoke: (intent) {
                          print('local action');
                          FocusScope.of(context).nextFocus();
                        } //_changeNodeFocus(context, "Down")
                            ),
                        UpbuttonIntent:
                            CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
                          print('local action up');
                          FocusScope.of(context).previousFocus();
                        } //_changeNodeFocus(context, "Down")
                                )
                      },
                      child: ProfileTextFields(
                          focusNode: _intentController.profileNodes![2],
                          textController: _lastNameController,
                          label: "Gemal" //_userController.user!.lastName,
                          ),
                    ),
                    Actions(
                      actions: <Type, Action<Intent>>{
                        DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                            onInvoke: (intent) {
                          print('local action');
                          FocusScope.of(context).nextFocus();
                        } //_changeNodeFocus(context, "Down")
                            ),
                        UpbuttonIntent:
                            CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
                          print('local action up');
                          FocusScope.of(context).previousFocus();
                        } //_changeNodeFocus(context, "Down")
                                )
                      },
                      child: ProfileTextFields(
                          focusNode: _intentController.profileNodes![3],
                          textController: _sexController,
                          label: "Male" //_userController.user!.sex,
                          ),
                    ),
                    Actions(
                      actions: <Type, Action<Intent>>{
                        DownbuttonIntent: CallbackAction<DownbuttonIntent>(
                            onInvoke: (intent) {
                          print('local action down');
                          FocusScope.of(context).nextFocus();
                        } //_changeNodeFocus(context, "Down")
                            ),
                        UpbuttonIntent:
                            CallbackAction<UpbuttonIntent>(onInvoke: (intent) {
                          print('local action up');
                          FocusScope.of(context).previousFocus();
                        } //_changeNodeFocus(context, "Down")
                                )
                      },
                      child: ProfileTextFields(
                          focusNode: _intentController.profileNodes![4],
                          textController: _countryController,
                          label: "Ethiopia" //_userController.user!.country,
                          ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    ElevatedButton(
                        focusNode: _intentController.profileNodes![5],
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          fixedSize: const Size(100, 35),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side:
                              BorderSide(color: Theme.of(context).dividerColor),
                        ),
                        onPressed: () {},
                        child: const Center(
                          child: Text("Update"),
                        ))
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
    return SizedBox(
      height: 40,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: TextFormField(
          onEditingComplete: () {
            print("Edite complete");
            FocusScope.of(context).nextFocus();
            print(FocusManager.instance.primaryFocus);
          },
          initialValue: label,
          focusNode: focusNode,
          //controller: textController,

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
    );
  }
}
