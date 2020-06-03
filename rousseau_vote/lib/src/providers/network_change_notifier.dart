

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

  void setError({ErrorState errorState = ErrorState.GENERIC_ERROR}) {
    _errorState = errorState;
    _moveToState(LoadingState.LOADING);
  }

  void startLoading() {
    _moveToState(LoadingState.LOADING);
  }
  
  void doneLoading() {
    _moveToState(LoadingState.LOADED);
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
