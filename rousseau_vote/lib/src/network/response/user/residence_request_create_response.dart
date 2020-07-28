import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/residence_change_request.dart';
part 'residence_request_create_response.g.dart';

@JsonSerializable()

class ResidenceRequestCreateResponse {
  ResidenceRequestCreateResponse();
  
  List<String> errors;
  ResidenceChangeRequest residenceChangeRequest;
  
  factory ResidenceRequestCreateResponse.fromJson(Map<String, dynamic> json) => _$ResidenceRequestCreateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResidenceRequestCreateResponseToJson(this);
}