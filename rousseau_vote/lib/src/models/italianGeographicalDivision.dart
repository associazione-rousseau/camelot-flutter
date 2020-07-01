import 'package:json_annotation/json_annotation.dart';
part 'italianGeographicalDivision.g.dart';

@JsonSerializable()
class ItalianGeographicalDivision {
  String id;
  String name;
  String code;
  String type;
  List<ItalianGeographicalDivision> descendants;

  factory ItalianGeographicalDivision.fromJson(Map<String, dynamic> json) =>
      _$ItalianGeographicalDivisionFromJson(json);
  Map<String, dynamic> toJson() => _$ItalianGeographicalDivisionToJson(this);

  ItalianGeographicalDivision(
      this.id, this.name, this.code, this.type, this.descendants) {
    print('itaGeoDiv constructor');
  }
}
