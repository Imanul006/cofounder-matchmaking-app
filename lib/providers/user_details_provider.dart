import 'package:flutter/foundation.dart';
import 'package:kiuqi/screens/login/view/login_page.dart';
import 'package:kiuqi/screens/user_details/components/basic_info_step.dart';
import 'package:kiuqi/screens/user_details/components/profile_step.dart';
import 'package:kiuqi/screens/user_details/components/startup_step.dart';
import 'package:kiuqi/screens/user_details/components/tagline_step.dart';
import 'package:kiuqi/services/api/user_details_api.dart';

class UserDetailsProvider with ChangeNotifier {
  int _currentStep = 0;
  final int _totalSteps = 5;
  String _buttonText = "Complete Step 1";
  bool _canGoToNextStep = false;
  bool _hasStartup = true;
  bool _isLoading = false;
  bool _isDataSubmitted = false;

  Map<String, dynamic>? _basicDetailsOutput;
  Map<String, dynamic>? _startupDetailsOutput;
  Map<String, dynamic>? _profileDetailsOutput;
  String? _taglineOutput;

  void disposeValues() {
    _currentStep = 0;

    _buttonText = "Complete Step 1";
    _canGoToNextStep = false;
    _hasStartup = true;
    _isLoading = false;
    _isDataSubmitted = false;
    _basicDetailsOutput = null;
    _startupDetailsOutput = null;
    _profileDetailsOutput = null;
    notifyListeners();
  }

  // ignore: prefer_final_fields
  Map<String, dynamic> _taglineMap = {
    "status": true,
    "form_name": "tagline_info",
    "startup_name": "XYZ LLC.",
    "helps": "something",
    "to": "something",
    "by": "something",
  };

  int get currentStep => _currentStep;
  int get totalSteps => _totalSteps;
  String get buttonText => _buttonText;
  Map<String, dynamic> get taglineMap => _taglineMap;
  bool get isLoading => _isLoading;
  bool get isDataSubmitted => _isDataSubmitted;

  void nextStep() async {
    switch (_currentStep) {
      case 0:
        {
          Map<String, dynamic> data = BasicInfoStep.submitFormData();
          if (kDebugMode) print("From Provider ::::: " + data.toString());
          _canGoToNextStep = data["status"];
          if (_canGoToNextStep) _basicDetailsOutput = data;
          _hasStartup = data["has_startup"] ?? false;
          break;
        }
      case 1:
        {
          Map<String, dynamic> data = StartupStep.submitFormData();
          _taglineMap["startup_name"] = data["startup_name"];
          if (kDebugMode) print("From Provider ::::: " + data.toString());
          _canGoToNextStep = data["status"];
          if (_canGoToNextStep) _startupDetailsOutput = data;
          break;
        }
      case 2:
        {
          Map<String, dynamic> data = TaglineStep.submitFormData();
          if (kDebugMode) print("From Provider ::::: " + data.toString());
          if (_hasStartup) {
            _taglineMap["helps"] = data["helps"];
            _taglineMap["to"] = data["to"];
            _taglineMap["by"] = data["by"];
          }
          _canGoToNextStep = data["status"];
          break;
        }
      case 3:
        {
          _canGoToNextStep = true;

          if (_canGoToNextStep) {
            _taglineOutput = _taglineMap["startup_name"] +
                " helps " +
                _taglineMap["helps"] +
                " to " +
                _taglineMap["to"] +
                " by " +
                _taglineMap["by"];
          }
          break;
        }
      case 4:
        {
          Map<String, dynamic> data = ProfileStep.submitFormData();
          if (kDebugMode) print("From Provider ::::: " + data.toString());
          _canGoToNextStep = data["status"];
          if (_canGoToNextStep) _profileDetailsOutput = data;
          // Sending data to API
          _isLoading = true;
          notifyListeners();
          bool _hasSubmitted = await _submitDetails();
          if (_hasSubmitted) {
            _isDataSubmitted = true;
            _isLoading = false;
            notifyListeners();
          } else {
            _isLoading = false;
            notifyListeners();
          }
          break;
        }
    }

    if (_canGoToNextStep) {
      _canGoToNextStep = false;
      if (_currentStep >= 0 && _currentStep < _totalSteps - 1) {
        if (_currentStep == 0 && !_hasStartup) {
          _currentStep = 4;
        } else {
          _currentStep++;
        }
        _updateButtonText();
        notifyListeners();
      }
    }
  }

  void previousStep() {
    _canGoToNextStep = false;
    if (_currentStep > 0 && _currentStep < _totalSteps) {
      if (_currentStep == 4 && !_hasStartup) {
        _currentStep = 0;
      } else {
        _currentStep--;
        _updateButtonText();
        notifyListeners();
      }
    }
  }

  void _updateButtonText() {
    switch (_currentStep) {
      case 0:
        {
          _buttonText = "Complete Step 1";
          break;
        }
      case 1:
        {
          _buttonText = "Complete Step 2";
          break;
        }
      case 2:
        {
          _buttonText = "Continue";
          break;
        }
      case 3:
        {
          _buttonText = "Complete Step 3";
          break;
        }
      case 4:
        {
          _buttonText = "Finish";
          break;
        }
      // case 5:
      //   {
      //     _buttonText = "Complete Step 5";
      //     break;
      //   }
      // case 6:
      //   {
      //     _buttonText = "Finish";
      //     break;
      //   }

      default:
        {
          _buttonText = "Undefined Page";
          break;
        }
    }
  }

  Future<bool> _submitDetails() async {
    bool _userDetailsResponse = await UserDetailsApi.updateUserDetails(
      name: _basicDetailsOutput!["name"],
      email: _basicDetailsOutput!["email"],
      dob: _basicDetailsOutput!["dob"],
      profilePic: _profileDetailsOutput!["profile_pic"],
      state: _basicDetailsOutput!["state"],
      city: _basicDetailsOutput!["city"],
    );
    if (!_userDetailsResponse) {
      if (kDebugMode) print("Error: Failed to update User Details.");
      return false;
    }

    bool _resumeDetailsResponse = await UserDetailsApi.updateResumeDetails(
      bio: _profileDetailsOutput!["bio"],
      category: _basicDetailsOutput!["category"],
      expertise: _basicDetailsOutput!["expertise"],
      startupCount: _basicDetailsOutput!["startup_count"],
      skills: _basicDetailsOutput!["skills"],
      hasStartup: _hasStartup.toString(),
    );
    if (!_resumeDetailsResponse) {
      if (kDebugMode) print("Error: Failed to update Resume Details.");
      return false;
    }

    if (_hasStartup) {
      bool _startupDetailsResponse = await UserDetailsApi.updateStartupDetails(
        name: _startupDetailsOutput!["startup_name"],
        legalName: _startupDetailsOutput!["legal_name"],
        tagline: _taglineOutput!,
        industry: _startupDetailsOutput!["industry"],
        dateFounded: _startupDetailsOutput!["dof"],
        kvIncubationId: _startupDetailsOutput!["incubation_id"],
        //TODO: Repair DateFounded error
      );
      if (!_startupDetailsResponse) {
        if (kDebugMode) print("Error: Failed to update Startup Details.");
        return false;
      }
    }

    return true;
  }
}
