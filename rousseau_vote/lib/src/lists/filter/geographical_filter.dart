import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';

class GeographicalFilter {
  ItalianGeographicalDivision geographicalDivision;

  bool get isSet => geographicalDivision != null;

  bool get isCountry => geographicalDivision != null && geographicalDivision.getType() == 'country';

  String get geographicalCode => geographicalDivision?.code;

  String get geographicalType => geographicalDivision?.getType();

  void reset() => geographicalDivision = null;
}
