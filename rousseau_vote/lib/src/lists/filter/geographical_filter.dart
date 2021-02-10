import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';

class GeographicalFilter {
  ItalianGeographicalDivision geographicalDivision;

  bool get isSet => geographicalDivision != null;

  bool get isCountry => geographicalDivision != null && geographicalDivision.getType() == 'country';

  String get geographicalCode => geographicalDivision?.code;

  String get geographicalType => geographicalDivision?.getType();

  String get geographicalName => geographicalDivision?.name;

  void reset() => geographicalDivision = null;
}
