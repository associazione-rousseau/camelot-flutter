

import 'package:flutter/widgets.dart';

abstract class NetworkChangeNotifier extends ChangeNotifier {
  LoadingState _loadingState;
  ErrorState _errorState;

  bool isLoading() {
    return _loadingState != LoadingState.LOADING;
  }

  LoadingState getState() {
    return _loadingState;
  }

  ErrorState getErrorState() {
    return _errorState;
  }

  bool hasErrors() {
    return _errorState != ErrorState.NO_ERRORS;
  }

  void setError({ErrorState errorState = ErrorState.GENERIC_ERROR, bool notify = true}) {
    _errorState = errorState;
    _moveToState(LoadingState.LOADED, notify: notify);
  }

  void startLoading({bool notify = true}) {
    _moveToState(LoadingState.LOADING, notify: notify);
  }
  
  void doneLoading({bool notify = true}) {
    _moveToState(LoadingState.LOADED, notify: notify);
  }

  void _moveToState(LoadingState loadingState, {bool notify = true}) {
    _loadingState = loadingState;
    if (notify) {
      notifyListeners();
    }
  }
}

enum LoadingState {
  LOADING,
  LOADED
}

enum ErrorState {
  NO_ERRORS,
  GENERIC_ERROR
}
