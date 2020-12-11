import 'package:json_annotation/json_annotation.dart';
part 'italianGeographicalDivision.g.dart';

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

  String get eventsCode => name.toLowerCase().replaceAll(' ', '-').replaceFirst("'", '-');
}
