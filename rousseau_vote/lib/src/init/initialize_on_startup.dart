
mixin InitializeOnStartup {
  bool _isInitialized;

  Future<void> initialize() {
    return doInitialize().whenComplete(() {_isInitialized = true;});
  }

  bool isInitialized() => _isInitialized;

  Future<void> doInitialize();
}