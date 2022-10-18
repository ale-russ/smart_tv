import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_tv/features/common/theme/themes.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'K'.tr,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: PrimaryColorTones.mainColor,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontSize: 20,
                      ),
                ),
                TextSpan(
                  text: "abbee".tr,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: DarkModeColors.onBackgroundColor.withAlpha(255),
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontSize: 20,
                      ),
                ),
                TextSpan(
                  text: '+'.tr,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: PrimaryColorTones.mainColor,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
