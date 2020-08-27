import 'package:json_annotation/json_annotation.dart';
part 'italianGeographicalDivision.g.dart';

@JsonSerializable()
class ItalianGeographicalDivision {

  ItalianGeographicalDivision(this.id, this.name, this.code, this.type, this.descendants);

  factory ItalianGeographicalDivision.fromJson(Map<String, dynamic> json) =>
      _$ItalianGeographicalDivisionFromJson(json);
  Map<String, dynamic> toJson() => _$ItalianGeographicalDivisionToJson(this);

  String id;
  String name;
  String code;
  String type;
  List<ItalianGeographicalDivision> descendants;

  String get eventsCode => name.toLowerCase().replaceAll(' ', '-').replaceFirst("'", '-');
}
