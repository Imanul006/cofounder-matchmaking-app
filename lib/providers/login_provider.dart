import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kiuqi/models/user_model.dart';
import 'package:kiuqi/services/api/auth_api.dart';
import 'package:kiuqi/services/api/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  bool _status = false;
  bool _isLoading = false;
  bool _isOtpScreen = false;
  bool _counterStatus = false;
  int _counterValue = 20;
  String _counterString = "Resend OTP in 20 Seconds";
  String? _name;

  // Getters
  bool get isLoading => _isLoading;
  bool get isOtpScreen => _isOtpScreen;
  bool get counterStatus => _counterStatus;
  String get counterString => _counterString;
  String? get name => _name;

  void disposeValues() {
  _status = false;
  _isLoading = false;
  _isOtpScreen = false;
  _counterStatus = false;
  _counterValue = 20;
  _counterString = "Resend OTP in 20 Seconds";
  _name = null;
  notifyListeners();
  }

  void sendOtp(String phone, bool resend) async {
    _isLoading = true;
    notifyListeners();
    _status = await AuthApi.sendOtp(
      resend: resend,
      phone: phone,
    );
    _isLoading = false;
    _isOtpScreen = true;

    startCounter();

    notifyListeners();
  }

  void goToPhoneScreen() {
    _isLoading = true;
    notifyListeners();
    _stopCounter();
    _isOtpScreen = false;
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> verifyOtp(String otp) async {
    final _loginData = await SharedPreferences.getInstance();

    _isLoading = true;
    notifyListeners();
    _status = await AuthApi.verifyOtp(otp);
    _isLoading = false;
    _name = _loginData.getString('name');
    notifyListeners();
    return _status;
  }

  void startCounter() {
    _counterValue = 20;
    _updateCounter();
  }

  void _stopCounter() {
    _counterValue = 0;
    _counterStatus = false;
  }

  void _updateCounter() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_counterValue <= 0 && !_counterStatus) {
          timer.cancel();
        }
        if (_counterValue > 0) {
          _counterStatus = true;
          _counterValue--;
          _counterString = "Resend OTP in $_counterValue Seconds";
          if (kDebugMode) {
            print(_counterString);
          }
        } else {
          _counterStatus = false;
          _counterString = "Resend OTP";
        }

        notifyListeners();
      },
    );
  }

  Future<bool> checkUserHasData() async {
    UserModel user = await UserApi.getCurrentUserDetails();
    if (user.name == null || user.name == "" || user.resume == null || user.resume!.bio == null || user.resume!.bio == "") {
      return false;
    } else {
      return true;
    }
  }
}
