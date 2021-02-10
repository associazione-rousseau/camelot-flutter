
class SearchFilter {
  String _word;

  void setWord(String word) => _word = word;

  String getWord() => _word;

  bool get isSet => _word != null && _word.isNotEmpty;

  void reset() => _word = null;
}
