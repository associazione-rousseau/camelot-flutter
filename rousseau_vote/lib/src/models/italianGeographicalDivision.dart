import 'package:json_annotation/json_annotation.dart';
part 'italianGeographicalDivision.g.dart';

const Map<String, int> SCORES = <String, int>{ 'country': 5, 'regione': 4, 'provincia': 3, 'comune': 2 , 'municipio': 1 };

@JsonSerializable()
class ItalianGeographicalDivision {

  ItalianGeographicalDivision();

  factory ItalianGeographicalDivision.fromJson(Map<String, dynamic> json) =>
      _$ItalianGeographicalDivisionFromJson(json);
  Map<String, dynamic> toJson() => _$ItalianGeographicalDivisionToJson(this);

  String id;
  String name;
  String code;
  String type;
  List<ItalianGeographicalDivision> descendants;

  String getType() => type;

  int get score => SCORES[type] ?? 0;

  String get eventsCode => name.toLowerCase().replaceAll(' ', '-').replaceFirst("'", '-');
}
