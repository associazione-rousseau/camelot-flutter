import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
part 'residence_change_request.g.dart';

@JsonSerializable()
class ResidenceChangeRequest {
  ResidenceChangeRequest();

  factory ResidenceChangeRequest.fromJson(Map<String, dynamic> json) => _$ResidenceChangeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ResidenceChangeRequestToJson(this);

  String status;
  ItalianGeographicalDivision country;
  ItalianGeographicalDivision regione;
  ItalianGeographicalDivision provincia;
  ItalianGeographicalDivision comune;
  ItalianGeographicalDivision municipio;
  String overseaseCity;
  
}
