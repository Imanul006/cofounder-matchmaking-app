import 'package:flutter/cupertino.dart';
import 'package:kiuqi/constants/colors.dart';

class BaseStyles {
  static TextStyle textButtonStyle =
      const TextStyle(color: AppColor.primaryText, fontSize: 18);

  static TextStyle titleTextStyle = const TextStyle(
      color: AppColor.primaryText, fontWeight: FontWeight.bold, fontSize: 20);

  static TextStyle bodyText = const TextStyle(
      color: AppColor.subtitleText,
      fontWeight: FontWeight.normal,
      fontSize: 18);

  static TextStyle primaryLargeTitleTextStyle = const TextStyle(
      color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 36);

  static TextStyle primaryBlackLargeTitleTextStyle = const TextStyle(
      color: AppColor.primaryText, fontWeight: FontWeight.bold, fontSize: 36);

  static TextStyle primaryTitleTextStyle = const TextStyle(
      color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 32);

  static TextStyle primarySmallTitleTextStyle = const TextStyle(
      color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 22);

  static TextStyle primarySmallBlackTitleTextStyle = const TextStyle(
      color: AppColor.primaryText, fontWeight: FontWeight.bold, fontSize: 22);    

  static TextStyle primaryExtraSmallTitleTextStyle = const TextStyle(
      color: AppColor.primaryColor, fontWeight: FontWeight.bold, fontSize: 15);
  
  static TextStyle primaryExtraSmallGreyTitleTextStyle = const TextStyle(
      color: AppColor.subtitleText, fontWeight: FontWeight.bold, fontSize: 15);

  static TextStyle titleTextWhiteStyle = const TextStyle(
      color: AppColor.buttonText, fontWeight: FontWeight.bold, fontSize: 20);

  static TextStyle pageHeadingTextStyle = const TextStyle(
      color: AppColor.buttonText, fontWeight: FontWeight.bold, fontSize: 36);

  static TextStyle headingTextStyle = const TextStyle(
      color: AppColor.primaryText, fontWeight: FontWeight.bold, fontSize: 26);

  static TextStyle subtitleTextStyle = const TextStyle(
      color: AppColor.primaryColor,
      fontWeight: FontWeight.normal,
      fontSize: 15);

  static TextStyle blackSubtitleTextStyle = const TextStyle(
      color: AppColor.subtitleText,
      fontWeight: FontWeight.normal,
      fontSize: 22);

  static TextStyle greySecondaryTextStyle = const TextStyle(
      color: AppColor.subtitleText, fontWeight: FontWeight.w600, fontSize: 28);

  static TextStyle greySmallSecondaryTextStyle = const TextStyle(
      color: AppColor.subtitleText, fontWeight: FontWeight.w500, fontSize: 16);

  static TextStyle blackSecondaryTextStyle = const TextStyle(
      color: AppColor.black, fontWeight: FontWeight.bold, fontSize: 28);

  static TextStyle blackSmallSecondaryTextStyle = const TextStyle(
      color: AppColor.black, fontWeight: FontWeight.bold, fontSize: 18);

  static TextStyle secondaryTextStyle = const TextStyle(
      color: AppColor.primaryColor, fontWeight: FontWeight.w700, fontSize: 30);

  static TextStyle textInputHintStyle = const TextStyle(
      color: AppColor.subtitleText, fontWeight: FontWeight.bold, fontSize: 20);

  static TextStyle navigationTextStyle = const TextStyle(
    color: AppColor.primaryText, fontWeight: FontWeight.w700, fontSize: 10, height: 1.5);

  static TextStyle italicTextStyle = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2, fontStyle: FontStyle.italic);
}
