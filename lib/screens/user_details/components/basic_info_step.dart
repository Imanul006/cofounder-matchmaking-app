import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kiuqi/app.dart';
import 'package:kiuqi/constants/lists.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:kiuqi/screens/user_details/components/startup_step.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String _name = "";
String _email = "";
String _category = "";
String _expertise = "";
String _dob = "";
String _state = "";
String _city = "";
String _startupCount = "";
String _skills = "";
bool _hasStartup = true;

class BasicInfoStep extends StatefulWidget {
  const BasicInfoStep({Key? key}) : super(key: key);

  static Map<String, dynamic> submitFormData() {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> dataMap = <String, dynamic>{};

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      dataMap = {
        "status": true,
        "form_name": "basic_info",
        "name": _name,
        "email": _email,
        "category": _category,
        "expertise": _expertise,
        "dob": _dob,
        "state": _state,
        "city": _city,
        "startup_count": _startupCount,
        "skills": _skills,
        "has_startup": _hasStartup
      };
    } else {
      dataMap = {
        "status": false,
        "form_name": "basic_info",
      };
    }
    return dataMap;
  }

  @override
  State<BasicInfoStep> createState() => _BasicInfoStepState();
}

class _BasicInfoStepState extends State<BasicInfoStep> {
  final dateFormat = DateFormat("dd-MM-yyyy");

  String? _selectedState;
  String? _selectedCategory;
  String? _selectedExpertise;
  String? _startupStatus = RadioButtonLists.hasStartupRadioValues[0];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Help others to know you better!",
            style: BaseStyles.primaryBlackLargeTitleTextStyle,
          ),
          const SizedBox(height: 50),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildNameField(),
                const SizedBox(height: 25),
                _buildEmailField(),
                const SizedBox(height: 25),
                _buildCategoryField(),
                const SizedBox(height: 25),
                _buildExpertiseField(),
                const SizedBox(height: 25),
                _buildDobField(),
                const SizedBox(height: 25),
                _buildStateField(),
                const SizedBox(height: 25),
                _buildCityField(),
                const SizedBox(height: 25),
                _buildStartupCountField(),
                const SizedBox(height: 25),
                _buildSkillsField(),
                const SizedBox(height: 25),
                _buildHasStartupField(),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        label: const Text("Full Name"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Name is required';
        }
        return null;
      },
      onSaved: (String? value) {
        _name = value!;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: InputBorder.none,
        label: const Text("Email Id"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Name is required';
        } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return 'Please enter a valid email id';
        } else {
          return null;
        }
      },
      onSaved: (String? value) {
        _email = value!;
      },
    );
  }

  Widget _buildCategoryField() {
    return DropdownButtonFormField(
      value: _selectedCategory,
      decoration: InputDecoration(
        border: InputBorder.none,
        label: const Text("Select Category"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Category is required';
        }
        return null;
      },
      items: DropdownLists.entrepreneurCategoryList.map((String? value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value!),
        );
      }).toList(),
      onChanged: (String? currentSelection) {
        _selectedCategory = currentSelection;
      },
      onSaved: (String? currentSelection) {
        if (currentSelection != null) _category = currentSelection;
      },
    );
  }

  Widget _buildExpertiseField() {
    return DropdownButtonFormField(
      value: _selectedExpertise,
      decoration: InputDecoration(
        border: InputBorder.none,
        label: const Text("Select Your Field of Expertise"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Field of expertise is required';
        }
        return null;
      },
      items: DropdownLists.fieldOfExpertiseList.map((String? value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value!),
        );
      }).toList(),
      onChanged: (String? currentSelection) {
        _selectedExpertise = currentSelection;
      },
      onSaved: (String? currentSelection) {
        if (currentSelection != null) _expertise = currentSelection;
      },
    );
  }

  Widget _buildDobField() {
    return DateTimeField(
      decoration: InputDecoration(
        border: InputBorder.none,
        label: const Text("Date of Birth"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      validator: (DateTime? value) {
        if (value == null) {
          return 'Date of birth is required';
        }
        return null;
      },
      onSaved: (DateTime? value) {
        DateFormat newFormat = DateFormat('dd/MM/yyyy');
        _dob = newFormat.format(value!).toString();
      },
      format: dateFormat,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime(1990),
            lastDate: DateTime.now());
      },
    );
  }

  Widget _buildStateField() {
    return DropdownButtonFormField(
      value: _selectedState,
      decoration: InputDecoration(
        border: InputBorder.none,
        label: const Text("State"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'State is required';
        }
        return null;
      },
      items: DropdownLists.stateList.map((String? value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value!),
        );
      }).toList(),
      onChanged: (String? currentSelection) {
        _selectedState = currentSelection;
      },
      onSaved: (String? currentSelection) {
        if (currentSelection != null) _state = currentSelection;
      },
    );
  }

  Widget _buildCityField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        label: const Text("City"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'City is required';
        }
        return null;
      },
      onSaved: (String? value) {
        _city = value!;
      },
    );
  }

  Widget _buildStartupCountField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: InputBorder.none,
        label: const Text("Total Startups Founded"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Name is required';
        }
        return null;
      },
      onSaved: (String? value) {
        _startupCount = value!;
      },
    );
  }

  Widget _buildSkillsField() {
    return TextFormField(
      maxLength: 250,
      maxLines: 5,
      decoration: InputDecoration(
        hintText:
            "Tell us little bit about your top skills (Within 250 characters).",
        border: InputBorder.none,
        label: const Text("Your Top Skills"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Top skills is required';
        }
        return null;
      },
      onSaved: (String? value) {
        _skills = value!;
      },
    );
  }

  Widget _buildHasStartupField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Selct an option below",
            style: BaseStyles.titleTextStyle,
          ),
        ),
        ListTile(
          title: Text(RadioButtonLists.hasStartupRadioValues[0]),
          leading: Radio<String>(
            value: RadioButtonLists.hasStartupRadioValues[0],
            groupValue: _startupStatus,
            onChanged: (String? value) {
              setState(() {
                _startupStatus = value;
                _hasStartup = true;
              });
            },
          ),
        ),
        ListTile(
          title: Text(RadioButtonLists.hasStartupRadioValues[1]),
          leading: Radio<String>(
            value: RadioButtonLists.hasStartupRadioValues[1],
            groupValue: _startupStatus,
            onChanged: (String? value) {
              setState(() {
                _startupStatus = value;
                _hasStartup = false;
              });
            },
          ),
        ),
      ],
    );
  }
}
