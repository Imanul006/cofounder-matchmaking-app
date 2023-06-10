import 'package:flutter/foundation.dart';
import 'package:kiuqi/constants/links.dart';
import 'package:kiuqi/models/cofounder_list_model.dart';
import 'package:kiuqi/models/connections_model.dart';
import 'package:kiuqi/models/interactions_model.dart';
import 'package:kiuqi/models/user_model.dart';
import 'package:kiuqi/services/api/cofounder_api.dart';
import 'package:kiuqi/services/api/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActionsProvider with ChangeNotifier {
  bool _requestIsActivated = false;
  bool _likeIsActivated = false;
  bool _rejectIsActivated = false;
  bool _isLoading = true;
  int _buttonIndex = 0;

  List<InteractionsModel> interactions = [];
  List<ConnectionsModel> connections = [];

  // Getters
  bool get requestIsActivated => _requestIsActivated;
  bool get likeIsActivated => _likeIsActivated;
  bool get rejectIsActivated => _rejectIsActivated;
  bool get isLoading => _isLoading;
  int get buttonIndex => _buttonIndex;

  void initInteractionState({required String id}) {
    _isLoading = true;
    _requestIsActivated =
        _currentUserIsInteracted(id, interactionType: "sent");
    _likeIsActivated = _currentUserIsInteracted(id, interactionType: "liked");
    _rejectIsActivated = _currentUserIsInteracted(id, interactionType: "rejected");
    if (_currentUserIsInteracted(id, interactionType: "incoming")) {
      _buttonIndex = 1;
    } else {
      if (currentUserIsConnected(id)) {
        _buttonIndex = 2;
      } else {
        _buttonIndex = 0;
      }
    }
    _isLoading = false;
  }

  Future<void> updateInteractionList() async {
    interactions = await UserApi.getCurrentUserInteractions();
  }

  Future<void> updateConnectionList() async {
    connections = await UserApi.getCurrentUserConnections();
  }

  Future<bool> acceptRequest(String id) async {
    _isLoading = true;
    notifyListeners();
    bool _status = await CofounderApi.acceptRequest(id);
    updateConnectionList();
    initInteractionState(id: id);
    _isLoading = false;
    notifyListeners();
    return _status;
  }

  Future<bool> deleteRequest(String id) async {
    _isLoading = true;
    notifyListeners();
    bool _status = await CofounderApi.deleteRequest(id);
    updateConnectionList();
    initInteractionState(id: id);
    _isLoading = false;
    notifyListeners();
    return _status;
  }

  Future<bool> removeConnection(String id) async {
    _isLoading = true;
    notifyListeners();
    bool _status = await CofounderApi.removeConnection(id);
    updateConnectionList();
    initInteractionState(id: id);
    _isLoading = false;
    notifyListeners();
    return _status;
  }

  Future<Map<String, bool>> sendOrUnsendRequest(String id) async {
    _isLoading = true;
    notifyListeners();
    if (!_requestIsActivated) {
      // Send request
      bool _status = await CofounderApi.sendRequest(id);
      if (_status) {
        await updateInteractionList();
        initInteractionState(id: id);
        _isLoading = false;
        notifyListeners();
      }  
      return {"isSent": true, "status": _status};
      
    } else {
      // Unsend request
      bool _status = await CofounderApi.unsendRequest(id);
      if (_status) {
        await updateInteractionList();
        initInteractionState(id: id);
        _isLoading = false;
        notifyListeners();
      }  
      return {"isSent": false, "status": _status};
    }
  }

  Future<Map<String, bool>> likeOrUnlike(String id) async {
    _isLoading = true;
    notifyListeners();
    if (!_likeIsActivated) {
      // Send request
      bool _status = await CofounderApi.like(id);
      if (_status) {
        await updateInteractionList();
        initInteractionState(id: id);
        _isLoading = false;
        notifyListeners();
      }  
      return {"isSent": true, "status": _status};
      
    } else {
      // Unsend request
      bool _status = await CofounderApi.like(id);
      if (_status) {
        await updateInteractionList();
        initInteractionState(id: id);
        _isLoading = false;
        notifyListeners();
      }  
      return {"isSent": false, "status": _status};
    }
  }

  Future<Map<String, bool>> rejectOrUnreject(String id) async {
    _isLoading = true;
    notifyListeners();
    if (!_rejectIsActivated) {
      // Send request
      bool _status = await CofounderApi.reject(id);
      if (_status) {
        await updateInteractionList();
        initInteractionState(id: id);
        _isLoading = false;
        notifyListeners();
      }  
      return {"isSent": true, "status": _status};
      
    } else {
      // Unsend request
      bool _status = await CofounderApi.reject(id);
      if (_status) {
        await updateInteractionList();
        initInteractionState(id: id);
        _isLoading = false;
        notifyListeners();
      }  
      return {"isSent": false, "status": _status};
    }
  }

  bool currentUserIsConnected(String id) {
    for (var item in connections) {
      if (item.connectedWith == id) {
        return true;
      }
    }
    return false;
  }

  bool _currentUserIsInteracted(String id, {required String interactionType}) {
    // To check if current user is interacted with given user id.
    for (var item in interactions) {
      if (item.interactedWith == id &&
          item.interactionType == interactionType) {
        return true;
      }
    }
    return false;
  }
}
