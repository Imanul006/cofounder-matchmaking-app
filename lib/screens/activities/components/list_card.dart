import 'package:flutter/material.dart';
import 'package:kiuqi/constants/colors.dart';
import 'package:kiuqi/constants/styles.dart';
import 'package:kiuqi/utils/extensions.dart';

class ListCard extends StatelessWidget {
  final String name;
  final String category;
  final String expertise;
  const ListCard({
    Key? key,
    required this.name,
    required this.category,
    required this.expertise,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColor.primaryColor,
              radius: 33,
              child: CircleAvatar(
                backgroundColor: Colors.orange[100],
                radius: 31,
                child: const CircleAvatar(
                  backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/project-x-test-2.appspot.com/o/profile-placeholder.png?alt=media&token=f86271fd-befd-49b8-95e2-b0d0d2a8790b"),
                  radius: 30,
                ),
              ),
            ),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.formatName(),
                  style: BaseStyles.primarySmallBlackTitleTextStyle,
                ),
                const SizedBox(width: 5),
                Text(
                  category.toTitleCase() + ", " + expertise.toTitleCase(),
                  style: BaseStyles.primaryExtraSmallGreyTitleTextStyle,
                ),  
              ],
            ),
          ],
        ),
      ),
    );
  }
}
