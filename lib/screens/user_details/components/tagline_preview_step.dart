import 'package:flutter/material.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:kiuqi/providers/user_details_provider.dart';
import 'package:provider/provider.dart';

class TaglinePreviewStep extends StatefulWidget {
  const TaglinePreviewStep({Key? key}) : super(key: key);

  @override
  State<TaglinePreviewStep> createState() => _TaglinePreviewStepState();
}

class _TaglinePreviewStepState extends State<TaglinePreviewStep> {
  @override
  Widget build(BuildContext context) {
    UserDetailsProvider userDetailsProvider = Provider.of(context, listen: true);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Lets create a beautiful tagline for your Startup.",
            style: BaseStyles.primaryBlackLargeTitleTextStyle,
          ),
          const SizedBox(height: 30),
          Text(
            "Fill in the Blanks with Right Words to Describe your Startup.",
            style: BaseStyles.primarySmallTitleTextStyle,
          ),
          const SizedBox(height: 30),
          Container(
            color: AppColor.backgroundColor,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(height: 1.35, letterSpacing: 4),
                    children: <TextSpan>[
                      TextSpan(
                        text: userDetailsProvider.taglineMap["startup_name"] + " ",
                        style: BaseStyles.secondaryTextStyle,
                      ),
                      TextSpan(
                        text: 'helps ',
                        style: BaseStyles.blackSecondaryTextStyle,
                      ),
                      TextSpan(
                        text: userDetailsProvider.taglineMap["helps"] + " ",
                        style: BaseStyles.secondaryTextStyle,
                      ),
                      TextSpan(
                        text: 'to ',
                        style: BaseStyles.blackSecondaryTextStyle,
                      ),
                      TextSpan(
                        text: userDetailsProvider.taglineMap["to"] + " ",
                        style: BaseStyles.secondaryTextStyle,
                      ),
                      TextSpan(
                        text: 'by ',
                        style: BaseStyles.blackSecondaryTextStyle,
                      ),
                      TextSpan(
                        text: userDetailsProvider.taglineMap["by"] + ".",
                        style: BaseStyles.secondaryTextStyle,
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
