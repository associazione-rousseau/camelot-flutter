
import 'package:rousseau_vote/src/models/profile/position.dart';

class PositionFilter {
  Position position;

  bool get isSet => position != null;

  List<String> get positionCodes => <String>[position.code];

  void reset() => position = null;
}