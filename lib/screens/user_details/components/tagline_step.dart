import 'package:flutter/material.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:kiuqi/providers/user_details_provider.dart';
import 'package:provider/provider.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String _helps = "";
String _to = "";
String _by = "";

class TaglineStep extends StatefulWidget {
  const TaglineStep({Key? key}) : super(key: key);

  static Map<String, dynamic> submitFormData() {
    FocusManager.instance.primaryFocus?.unfocus();
    Map<String, dynamic> dataMap = <String, dynamic>{};
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      dataMap = {
        "status": true,
        "form_name": "tagline_info",
        "helps": _helps,
        "to": _to,
        "by": _by,
      };
    } else {
      dataMap = {
        "status": false,
        "form_name": "tagline_info",
      };
    }
    return dataMap;
  }

  @override
  State<TaglineStep> createState() => _TaglineStepState();
}

class _TaglineStepState extends State<TaglineStep> {
  @override
  Widget build(BuildContext context) {
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      context.read<UserDetailsProvider>().taglineMap["startup_name"],
                      style: BaseStyles.secondaryTextStyle,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      "helps",
                      style: BaseStyles.greySecondaryTextStyle,
                    ),
                    const SizedBox(height: 8),
                    _buildHelpsField(),
                    const SizedBox(height: 18),
                    Text(
                      "to",
                      style: BaseStyles.greySecondaryTextStyle,
                    ),
                    const SizedBox(height: 8),
                    _buildToField(),
                    const SizedBox(height: 18),
                    Text(
                      "by",
                      style: BaseStyles.greySecondaryTextStyle,
                    ),
                    const SizedBox(height: 8),
                    _buildByField(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHelpsField() {
    return TextFormField(
      style: BaseStyles.secondaryTextStyle,
      textAlign: TextAlign.center,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Helps field is required';
        }
        return null;
      },
      onSaved: (String? value) {
        _helps = value!;
      },
    );
  }

  Widget _buildToField() {
    return TextFormField(
      style: BaseStyles.secondaryTextStyle,
      textAlign: TextAlign.center,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'To field is required';
        }
        return null;
      },
      onSaved: (String? value) {
        _to = value!;
      },
    );
  }

  Widget _buildByField() {
    return TextFormField(
      style: BaseStyles.secondaryTextStyle,
      textAlign: TextAlign.center,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'By field is required';
        }
        return null;
      },
      onSaved: (String? value) {
        _by = value!;
      },
    );
  }
}
