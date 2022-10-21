import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tv/features/authentication/controller/login_controller.dart';
import 'package:smart_tv/features/authentication/controller/translation_controller.dart';

import '../../../common/controller/global_controller.dart';
import '../../../common/theme/icon_themes.dart';
import '../../../common/theme/text_themes.dart';
import '../../../common/theme/themes.dart';

// const List<String> languages = <String>['English', 'ትግርኛ'];

const List<String> languages = <String>['ትግርኛ', 'English'];

class LangaugeSelector extends GetView<GlobalController> {
  LangaugeSelector({
    Key? key,
  }) : super(key: key);

  LanguageController myController = Get.put(LanguageController());
  LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      height: 40,
      width: 90,
      child: Center(
        child: DropdownButton(
          focusNode: _loginController.loginNodes.value[5],
          onChanged: (String? value) async {
            if (value != null) {
              myController.langValue.value = value.toString();
            }
            //print(value);
            if (value == 'ትግርኛ') {
              print('value is before $value');
              myController.changeLanguage('ti', 'ER');
              //print('value is after $value');
            }
            //myController.changeLanguage('en', 'US')
            else {
              myController.changeLanguage('en', 'US');
            }
          },
          value: myController.langValue.value,
          style: TextStyle(color: Colors.white, fontSize: 16),
          // style: Theme.of(context).textTheme.subtitle1!,
          underline: Container(
            height: 2,
            color: Colors.grey,
          ),
          dropdownColor: DarkModeColors.surfaceColor,
          icon: KabbeeIcons.web(color: Colors.grey),
          items: languages.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem(
                value: value,
                child: KabbeeText(
                  value,
                  customStyle: TextStyle(color: Colors.white),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
