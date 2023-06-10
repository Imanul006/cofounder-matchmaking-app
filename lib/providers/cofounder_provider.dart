import 'package:flutter/foundation.dart';
import 'package:kiuqi/constants/links.dart';
import 'package:kiuqi/models/cofounder_list_model.dart';
import 'package:kiuqi/models/user_model.dart';
import 'package:kiuqi/services/api/cofounder_api.dart';

class CofounderProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _hasSnapshot = false;
  int _currentPagination = 1;
  int _totalPagination = 1;
  final List<UserModel> _cofounderData = [];
  final List<UserModel> _interactedUserData = [];

  // Getters
  bool get isLoading => _isLoading;
  bool get hasSnapshot => _hasSnapshot;
  List<UserModel> get cofounderData => _cofounderData;
  List<UserModel> get interactedUserData => _interactedUserData;

  void retrieveCofounderData() async {
    if (_currentPagination <= _totalPagination) {
      try {
        CofounderListModel _cofounders =
            await CofounderApi.fetchUsersByPagination(page: _currentPagination);
        _totalPagination = _cofounders.totalPages!;
        _cofounderData.addAll(_cofounders.results!);
        if (kDebugMode) print("Fetched data :: Page: $_currentPagination, Limit : $API_FETCH_LIMIT");
        _isLoading = false;
        notifyListeners();
      } catch (e) {
        if (kDebugMode) print("Exception Occoured : " + e.toString());
      }
    }
    _currentPagination++;
  }

  void retrieveCofounderDataByInteractionType( {required String interactionType} ) async { 
    // List<UserModel> _interactedCofounders = [];
    _interactedUserData.clear();
    _isLoading = true;
    try {
      
      List<UserModel> _userList =
          await CofounderApi.fetchUsersByInteractionType(interactionType: interactionType);
      print("RESULTS1................" + _userList.toString());    
      _isLoading = false;
      print("RESULTS2................" + _userList.toString());
       _interactedUserData.addAll(_userList);
       notifyListeners();
    } catch (e) {
      if (kDebugMode) print("Exception Occoured : " + e.toString());
    }
  }
}
