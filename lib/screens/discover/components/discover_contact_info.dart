import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:kiuqi/utils/custom_widgets.dart';

class DiscoverContactInfo extends StatelessWidget {
  final String phone;
  final String email;
  final bool isHidden;

  const DiscoverContactInfo({
    Key? key,
    required this.phone,
    required this.email,
    required this.isHidden,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.componentSideMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Info",
            style: BaseStyles.headingTextStyle,
          ),
          const SizedBox(height: 14),
          Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(Sizes.componentSideMargin),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomWidgets.keyValueAlt(
                      key: "Email",
                      value: isHidden ? "******@****.com" : email,
                      icon: FontAwesomeIcons.solidEnvelope),
                  const SizedBox(height: 14),
                  CustomWidgets.keyValueAlt(
                      key: "Phone Number",
                      value:
                          isHidden ? phone.substring(0, 6) + "*******" : phone,
                      icon: FontAwesomeIcons.phoneAlt),
                  Visibility(
                    visible: isHidden,
                    child: Column(
                      children: [
                        const Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Card(
                              elevation: 4,
                              color: Colors.white,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: FaIcon(FontAwesomeIcons.userLock,
                                    size: 20, color: AppColor.primaryColor),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Connect to view contact details.",
                                style: BaseStyles.greySmallSecondaryTextStyle,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
