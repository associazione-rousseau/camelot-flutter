import 'package:flutter/foundation.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';

class CurrentUserProvider extends ChangeNotifier {
  CurrentUser _currentUser;
  
  CurrentUser get currentUser{
    return _currentUser;
  }

  void setCurrentUser(CurrentUser cu) {
    _currentUser = cu;
    notifyListeners();
  }
}