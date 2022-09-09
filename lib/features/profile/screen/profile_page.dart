import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/authentication/view/login_page.dart';

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
                    textController: _firstNameController,
                    label: "Alem",
                  ),
                  ProfileTextFields(
                    textController: _lastNameController,
                    label: "Russom",
                  ),
                  ProfileTextFields(
                    textController: _sexController,
                    label: "Male",
                  ),
                  ProfileTextFields(
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
  }) : super(key: key);

  final TextEditingController textController;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: SizedBox(
        height: 30,
        width: 300,
        child: TextFormField(
          focusNode: FocusNode(),
          initialValue: label,
          // controller: textController,
          decoration: InputDecoration(
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
