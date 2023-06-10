import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiuqi/constants/values.dart';

TextEditingController _bioController = TextEditingController();

class ProfileStep extends StatefulWidget {
  const ProfileStep({Key? key}) : super(key: key);

  static Map<String, dynamic> submitFormData() {
    FocusManager.instance.primaryFocus?.unfocus();
    //TODO: Configure profile picture field
    String _dp = "";
    String _controllerValue = _bioController.text.trim();
    String _bio = !(_controllerValue.isEmpty || _controllerValue == "")
        ? _controllerValue
        : "Hello Entrepreneurs, I am using Kiuqi.";
    Map<String, dynamic> dataMap = {
      "status": true,
      "form_name": "profile_info",
      "profile_pic": _dp,
      "bio": _bio,
    };
    return dataMap;
  }

  @override
  State<ProfileStep> createState() => _ProfileStepState();
}

class _ProfileStepState extends State<ProfileStep> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            "Lets add a face and bio to the name",
            style: BaseStyles.primaryBlackLargeTitleTextStyle,
          ),
          const SizedBox(height: 30),
          Text(
            "Almost complete! Let’s make sure you show who you are.",
            style: BaseStyles.primarySmallTitleTextStyle,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          // Row(
          //   children: [
          //     Expanded(
          //     ),
          //   const SizedBox(width: 20),
          //   CircleAvatar(
          //     radius: 16.0,
          //     child: ClipRRect(
          //       child: Image.network('https://firebasestorage.googleapis.com/v0/b/project-x-test-2.appspot.com/o/Profile%20Pictures%2Fimon.png?alt=media&token=13bd1d13-842e-45a0-b535-ea9b40210dfa',),
          //       borderRadius: BorderRadius.circular(50.0),
          //     ),
          //   ),
          //   ],
          // ),
          _buildDpField(),
          const SizedBox(height: 25),
          _buildBioField(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildDpField() {
    return RawMaterialButton(
      onPressed: (() => print("Select DP")),
      elevation: 5.0,
      fillColor: AppColor.primaryColor,
      padding: const EdgeInsets.all(15.0),
      shape: const CircleBorder(),
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: FaIcon(
          FontAwesomeIcons.camera,
          color: Colors.white,
          size: 38.0,
        ),
      ),
    );
  }

  Widget _buildBioField() {
    return TextFormField(
      controller: _bioController,
      maxLength: 200,
      style: const TextStyle(height: 1.3, fontSize: 20),
      decoration: InputDecoration(
        hintText: "Tell us little bit about yourself (Max 200 characters).",
        border: InputBorder.none,
        label: const Text("Bio"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 5,
    );
  }
}
