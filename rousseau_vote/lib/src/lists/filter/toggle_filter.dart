
class ToggleFilter {

  ToggleFilter(int n) : _toggles = List<bool>.filled(n, false, growable: false);

  final List<bool> _toggles;

  void toggle(int i) {
    _toggles[i] = !_toggles[i];
  }

  bool get hasActives {
    for(bool value in _toggles) {
      if (value) {
        return true;
      }
    }
    return false;
  }

  bool reset() {
    for(int i = 0; i < _toggles.length; i++) {
      _toggles[i] = false;
    }
  }

  List<bool> get values => _toggles;

  bool isActive(int i) => _toggles[i];
}
