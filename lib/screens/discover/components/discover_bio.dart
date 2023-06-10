import 'package:flutter/material.dart';
import 'package:kiuqi/constants/values.dart';

class DiscoverBio extends StatelessWidget {
  final String name;
  final String bio;
  const DiscoverBio({Key? key, required this.name, required this.bio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.componentSideMargin),
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(Sizes.componentSideMargin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About " + name.trim().split(" ").first,
                style: BaseStyles.headingTextStyle,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                bio,
                style: BaseStyles.bodyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
