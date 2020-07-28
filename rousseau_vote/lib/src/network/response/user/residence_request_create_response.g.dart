// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residence_request_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResidenceRequestCreateResponse _$ResidenceRequestCreateResponseFromJson(
    Map<String, dynamic> json) {
  return ResidenceRequestCreateResponse()
    ..errors = (json['errors'] as List)?.map((e) => e as String)?.toList()
    ..residenceChangeRequest = json['residenceChangeRequest'] == null
        ? null
        : ResidenceChangeRequest.fromJson(
            json['residenceChangeRequest'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ResidenceRequestCreateResponseToJson(
        ResidenceRequestCreateResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'residenceChangeRequest': instance.residenceChangeRequest,
    };
