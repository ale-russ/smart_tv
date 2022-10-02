import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/controller/global_controller.dart';
import '../../../common/theme/icon_themes.dart';
import '../../../common/theme/text_themes.dart';
import '../../../common/theme/themes.dart';

const List<String> languages = <String>['English', 'Tigrigna'];

class LangaugeSelector extends GetView<GlobalController> {
  LangaugeSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      onChanged: (String? value) async {
        if (value != null) {
          await controller.setAppLanguage(selectedLanguage: value);
        }
      },
      value: controller.defaultLanguage,
      style: TextStyle(color: Colors.white, fontSize: 16),
      // style: Theme.of(context).textTheme.subtitle1!,
      underline: Container(
        height: 2,
        color: Theme.of(context).textTheme.subtitle1!.color,
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
    );
  }
}
