import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';

part 'country_list.g.dart';

@JsonSerializable()
class CountryList {

  CountryList();

  factory CountryList.fromJson(Map<String, dynamic> json) => _$CountryListFromJson(json);
  Map<String, dynamic> toJson() => _$CountryListToJson(this);

  List<ItalianGeographicalDivision> countries;
}