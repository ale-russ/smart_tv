import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class KabbeeText extends StatelessWidget {
  const KabbeeText(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = null,
        super(key: key);

  const KabbeeText.bodyText1(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'bodyText1',
        super(key: key);

  const KabbeeText.bodyText2(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'bodyText2',
        super(key: key);

  const KabbeeText.bodySmall(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'bodySmall',
        super(key: key);

  const KabbeeText.bodyMedium(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'bodyMedium',
        super(key: key);

  const KabbeeText.subtitle1(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'subtitle1',
        super(key: key);

  const KabbeeText.subtitle2(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'subtitle2',
        super(key: key);

  const KabbeeText.caption(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'caption',
        super(key: key);

  const KabbeeText.headline1(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'headline1',
        super(key: key);

  const KabbeeText.headline2(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'headline2',
        super(key: key);

  const KabbeeText.headline3(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'headline3',
        super(key: key);

  const KabbeeText.headline4(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'headline4',
        super(key: key);

  const KabbeeText.headline5(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'headline5',
        super(key: key);

  const KabbeeText.headline6(
    this.text, {
    Key? key,
    this.customStyle,
    this.textAlign,
    this.maxLines,
    this.softWrap,
    this.overflow,
    this.textDirection,
    this.isSelectable = false,
  })  : styleName = 'headline6',
        super(key: key);

  final String text;

  final String? styleName;
  final TextStyle? customStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final ui.TextDirection? textDirection;

  final bool isSelectable;

  @override
  Widget build(BuildContext context) {
    TextStyle? getTextStyle(String? type) {
      switch (styleName) {
        case 'headline1':
          return Theme.of(context).textTheme.headline1?.merge(customStyle);
        case 'headline2':
          return Theme.of(context).textTheme.headline2?.merge(customStyle);
        case 'headline3':
          return Theme.of(context).textTheme.headline3?.merge(customStyle);
        case 'headline4':
          return Theme.of(context).textTheme.headline4?.merge(customStyle);
        case 'headline5':
          return Theme.of(context).textTheme.headline5?.merge(customStyle);
        case 'headline6':
          return Theme.of(context).textTheme.headline6?.merge(customStyle);
        case 'subtitle1':
          return Theme.of(context).textTheme.subtitle1?.merge(customStyle);
        case 'subtitle2':
          return Theme.of(context).textTheme.subtitle2?.merge(customStyle);
        case 'caption':
          return Theme.of(context).textTheme.caption?.merge(customStyle);
        case 'bodyText1':
          return Theme.of(context).textTheme.bodyText1?.merge(customStyle);
        case 'bodyText2':
          return Theme.of(context).textTheme.bodyText2?.merge(customStyle);
        case 'bodySmall':
          return Theme.of(context).textTheme.bodySmall?.merge(customStyle);
        case 'bodyMedium':
          return Theme.of(context).textTheme.bodyMedium?.merge(customStyle);
        default:
          return null;
          return Theme.of(context).textTheme.bodyText2?.merge(customStyle);
      }
    }

    if (isSelectable) {
      return SelectableText(
        text,
        style: getTextStyle(styleName),
        textAlign: textAlign,
        maxLines: maxLines,
        textDirection: textDirection,
      );
    }

    return Text(
      text,
      style: getTextStyle(styleName),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }
}
