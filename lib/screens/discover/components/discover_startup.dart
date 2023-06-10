import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:kiuqi/utils/custom_widgets.dart';

final DateFormat formatter = DateFormat('MMM dd, yyyy');

class DiscoverStartup extends StatelessWidget {
  final bool hasStartup;
  final String? name;
  final String? legalName;
  final String? tagline;
  final String? industry;
  final DateTime? dateFounded;

  const DiscoverStartup({
    Key? key,
    required this.hasStartup,
    this.name,
    this.legalName,
    this.tagline,
    this.industry,
    this.dateFounded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.componentSideMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Startup Details",
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
              child: hasStartup ? _buildHasStartup() : _buildHasNoStartup(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHasStartup() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name!,
          style: BaseStyles.headingTextStyle,
        ),
        const SizedBox(height: 6),
        Visibility(
          visible: (legalName!.isNotEmpty || legalName != ""),
          child: Text(
            legalName!,
            style: BaseStyles.primarySmallTitleTextStyle,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          tagline!,
          textAlign: TextAlign.start,
          style: BaseStyles.bodyText,
        ),
        const SizedBox(height: 32),
        CustomWidgets.keyValueAlt(
            key: "Industry", value: industry!, icon: FontAwesomeIcons.industry),
        const SizedBox(height: 14),
        CustomWidgets.keyValueAlt(
            key: "Founded on",
            value: formatter.format(dateFounded!),
            icon: FontAwesomeIcons.calendarAlt),
      ],
    );
  }

  Widget _buildHasNoStartup() {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Card(
            elevation: 4,
            color: Colors.white,
            shape: CircleBorder(),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: FaIcon(
                FontAwesomeIcons.userTimes,
                size: 20,
                color: AppColor.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "This entrepreneur currently not working on a startup idea.",
              style: BaseStyles.greySmallSecondaryTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
