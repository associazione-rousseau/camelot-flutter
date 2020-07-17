import 'package:json_annotation/json_annotation.dart';

part 'geographical_scope.g.dart';

@JsonSerializable()
class GeographicalScope {
  GeographicalScope();

  factory GeographicalScope.fromJson(Map<String, dynamic> json) => _$GeographicalScopeFromJson(json);
  Map<String, dynamic> toJson() => _$GeographicalScopeToJson(this);

  String name;
  String type;
}
