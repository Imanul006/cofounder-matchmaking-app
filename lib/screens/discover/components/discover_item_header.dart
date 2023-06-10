import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiuqi/utils/custom_widgets.dart';
import 'package:kiuqi/utils/extensions.dart';
import 'package:kiuqi/constants/values.dart';

class DiscoverItemHeader extends StatefulWidget {
  final String name;
  final String location;
  final String profilePic;
  final double age;
  final String category;
  final String skills;
  final String expertise;
  final double startupCount;
  final bool hasStartup;
  final bool isHidden;
  final bool isUserDetails;

  const DiscoverItemHeader({
    Key? key,
    required this.name,
    required this.age,
    required this.location,
    required this.profilePic,
    required this.category,
    required this.expertise,
    required this.startupCount,
    required this.hasStartup,
    required this.skills,
    required this.isHidden,
    required this.isUserDetails,
  }) : super(key: key);

  @override
  State<DiscoverItemHeader> createState() => _DiscoverItemHeaderState();
}

class _DiscoverItemHeaderState extends State<DiscoverItemHeader> {
  @override
  Widget build(BuildContext context) {
    final Size _viewPort = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: AppColor.discoverHeaderGradient,
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80.0),
              bottomRight: Radius.circular(80.0),
            ),
          ),
          height: 300,
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Sizes.componentSideMargin,
                  15,
                  15,
                  Sizes.componentSideMargin,
                ),
                child: Row(
                  children: [
                    Visibility(
                      visible: widget.isUserDetails,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(FontAwesomeIcons.arrowLeft, color: AppColor.buttonText,),
                      ),
                    ),
                    Text(
                      !widget.isUserDetails ? "Discover" : "User Details",
                      style: BaseStyles.pageHeadingTextStyle,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      //height: _viewPort.height * 0.666 - 20,
                      width: _viewPort.width - Sizes.componentSideMargin * 2,
                      child: DetailsSection(
                        age: widget.age,
                        category: widget.category,
                        expertise: widget.expertise,
                        hasStartup: widget.hasStartup,
                        location: widget.location,
                        name: widget.name,
                        profilePic: widget.profilePic,
                        startupCount: widget.startupCount,
                        skills: widget.skills,
                        isHidden: widget.isHidden,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class DetailsSection extends StatelessWidget {
  final String name;
  final String location;
  final String profilePic;
  final double age;
  final String category;
  final String expertise;
  final String skills;
  final double startupCount;
  final bool hasStartup;
  final bool isHidden;

  const DetailsSection({
    Key? key,
    required this.name,
    required this.age,
    required this.location,
    required this.profilePic,
    required this.category,
    required this.expertise,
    required this.startupCount,
    required this.hasStartup,
    required this.skills,
    required this.isHidden,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColor.primaryColor,
            radius: 85,
            child: CircleAvatar(
              backgroundColor: Colors.orange[100],
              radius: 82,
              child: CircleAvatar(
                backgroundImage: NetworkImage(profilePic),
                radius: 80,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isHidden ? name.formatName() : name,
                style: BaseStyles.headingTextStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                category.toTitleCase(),
                style: BaseStyles.subtitleTextStyle,
              )
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                  child: CustomWidgets.keyValueCard(
                      key: 'Exp.',
                      value: startupCount.toInt().toString(),
                      valueType: "Startups")),
              Expanded(
                  child: CustomWidgets.keyValueCard(
                      key: 'Age',
                      value: age.toInt().toString(),
                      valueType: "Years")),
            ],
          ),
          const SizedBox(height: 18),
          CustomWidgets.keyValueAlt(
              key: "Expertise", value: expertise, icon: FontAwesomeIcons.brain),
          CustomWidgets.keyValueAlt(
              key: "Location",
              value: location,
              icon: FontAwesomeIcons.mapMarkedAlt),
          const SizedBox(height: 14),
          const Divider(),
          const SizedBox(height: 5),
          Align(
              alignment: Alignment.topLeft,
              child: Text("Skills",
                  style: BaseStyles.primaryExtraSmallTitleTextStyle)),
          SizedBox(
              width: double.infinity,
              child: Text(skills,
                  textAlign: TextAlign.left,
                  style: BaseStyles.greySmallSecondaryTextStyle)),
        ],
      ),
    );
  }
}
