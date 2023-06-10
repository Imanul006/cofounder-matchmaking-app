import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiuqi/constants/values.dart';

class CustomWidgets {
  static Widget keyValueAlt({ required String key, required String value, required IconData icon }){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          elevation: 4,
          color: AppColor.primaryColor,
          shape: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FaIcon(icon, size: 20, color: Colors.white),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(key.trim(), style: BaseStyles.primaryExtraSmallTitleTextStyle),
              Text(value.trim(), style: BaseStyles.greySmallSecondaryTextStyle),
            ],
          ),
        )
      ],
    );
  }

  static Widget keyValueCard({ required String key, required String value, String? valueType }) {
    return Card(
      elevation: 7,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(20),
        //   bottomRight: Radius.circular(20),
        // ),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              key.trim(),
              style: BaseStyles.titleTextStyle,
            ),
            Text(
              value.trim(),
              style: BaseStyles.primarySmallTitleTextStyle,
            ),
            Text(
              valueType ?? "",
              style: BaseStyles.primaryExtraSmallTitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}