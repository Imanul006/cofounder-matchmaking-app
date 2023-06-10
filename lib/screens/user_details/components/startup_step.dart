import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kiuqi/constants/colors.dart';
import 'package:kiuqi/constants/lists.dart';
import 'package:kiuqi/constants/styles.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String _startupName = "";
String _legalName = "";
String _industry = "";
String _dof = "";
String _incubationId = "";

class StartupStep extends StatefulWidget {
  const StartupStep({Key? key}) : super(key: key);

  static Map<String, dynamic> submitFormData() {
    FocusManager.instance.primaryFocus?.unfocus();
    Map<String, dynamic> dataMap = <String, dynamic>{};
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      dataMap = {
        "status": true,
        "form_name": "startup_info",
        "startup_name": _startupName,
        "legal_name": _legalName,
        "industry": _industry,
        "dof": _dof,
        "incubation_id": _incubationId,
      };
    } else {
      dataMap = {
        "status": false,
        "form_name": "startup_info",
      };
    }
    return dataMap;
  }

  @override
  State<StartupStep> createState() => _StartupStepState();
}

class _StartupStepState extends State<StartupStep> {
  String? _selectedIndustry;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Help others to know your idea better!",
            style: BaseStyles.primaryBlackLargeTitleTextStyle,
          ),
          const SizedBox(height: 50),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildStartupNameField(),
                const SizedBox(height: 25),
                _buildLegalNameField(),
                const SizedBox(height: 25),
                _buildIndustryField(),
                const SizedBox(height: 25),
                _buildDofField(),
                const SizedBox(height: 25),
                _buildIncubationIdField(),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartupNameField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        label: const Text("Startup Name"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Startup name is required';
        }
        return null;
      },
      onSaved: (String? value) {
        _startupName = value!;
      },
    );
  }

  Widget _buildLegalNameField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Ignore if company not yet registered",
        border: InputBorder.none,
        label: const Text("Startup Legal Name"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      onSaved: (String? value) {
        if (value == null) {
          _legalName = "";
        } else {
          _legalName = value;
        }
      },
    );
  }

  Widget _buildIndustryField() {
    return DropdownButtonFormField(
      value: _selectedIndustry,
      isExpanded: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        label: const Text("Select Industry Category"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Industry category is required';
        }
        return null;
      },
      items: DropdownLists.industryList.map((String? value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value!,
            overflow: TextOverflow.visible,
          ),
        );
      }).toList(),
      onChanged: (String? currentSelection) {
        _selectedIndustry = currentSelection;
      },
      onSaved: (String? currentSelection) {
        if (currentSelection != null) _industry = currentSelection;
      },
    );
  }

  Widget _buildDofField() {
    final dateFormat = DateFormat("dd-MM-yyyy");
    return DateTimeField(
      decoration: InputDecoration(
        border: InputBorder.none,
        label: const Text("Date & Year Founded"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      validator: (DateTime? value) {
        if (value == null) {
          return 'Date founded is required';
        }
        return null;
      },
      onSaved: (DateTime? value) {
        DateFormat newFormat = DateFormat('dd/MM/yyyy');
        _dof = newFormat.format(value!).toString();
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

  Widget _buildIncubationIdField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Ignore if not incubated by KV",
        border: InputBorder.none,
        label: const Text("Kolkata Ventures Incubation ID"),
        fillColor: AppColor.inputFieldBlueishBackground,
        filled: true,
      ),
      onSaved: (String? value) {
        if (value == null) {
          _incubationId = "";
        } else {
          _incubationId = value;
        }
      },
    );
  }
}
