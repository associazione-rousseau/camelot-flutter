
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

  List<bool> get values => _toggles;

  bool isActive(int i) => _toggles[i];
}
