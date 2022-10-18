import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/theme/text_themes.dart';
import '../../common/theme/themes.dart';
import '../controller/login_controller.dart';

class RememberMe extends StatelessWidget {
  const RememberMe({
    Key? key,
    required this.loginController,
  }) : super(key: key);

  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    print("Rememberme is ${loginController.isRememberMe}");
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          constraints: const BoxConstraints(maxWidth: 18, maxHeight: 18),
          child: Obx(
            () => Checkbox(
              activeColor: PrimaryColorTones.mainColor,
              value: loginController.isRememberMe.value,
              onChanged: loginController.setRememberMe,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              splashRadius: 0.0,
              side: BorderSide(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 5),
        KabbeeText.subtitle1(
          'Remember me'.tr,
          customStyle: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
