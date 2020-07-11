import 'package:injectable/injectable.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/providers/network_change_notifier.dart';

@singleton
class CurrentUserProvider extends NetworkChangeNotifier {

  CurrentUserProvider(this._userNetworkHandler);

  final UserNetworkHandler _userNetworkHandler;
  CurrentUser _currentUser;

  CurrentUser getCurrentUser() {
    if(_currentUser != null) {
      return _currentUser;
    }

    startLoading();

    _fetchCurrentUser().then((CurrentUser currentUser) {
      _currentUser = currentUser;
      doneLoading();
    }).catchError((){
      setError();
    });

    return null;
  }

  Future<CurrentUser> _fetchCurrentUser() async {
    return _userNetworkHandler.fetchCurrentUser();
  }

  Future<CurrentUser> updateCurrentUser(CurrentUser currentUser) {
    startLoading();

    _userNetworkHandler.updateCurrentUser(currentUser).then((CurrentUser currentUser) {
      _currentUser = currentUser;
      doneLoading();
    }).catchError((_) {
      setError();
    });
  }
}