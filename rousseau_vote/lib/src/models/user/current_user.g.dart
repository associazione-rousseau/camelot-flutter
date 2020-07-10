// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) {
  return CurrentUser()
    ..id = json['id'] as String
    ..email = json['email'] as String
    ..fullName = json['fullName'] as String
    ..statusColor = json['statusColor'] as String
    ..slug = json['slug'] as String
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..voteRightStartingCountDate = json['voteRightStartingCountDate'] == null
        ? null
        : DateTime.parse(json['voteRightStartingCountDate'] as String)
    ..profile = json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>)
    ..gender = json['gender'] as String
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..codiceFiscale = json['codiceFiscale'] as String
    ..dateOfBirth = json['dateOfBirth'] as String
    ..placeOfBirth = json['placeOfBirth'] as String
    ..phoneNumber = json['phoneNumber'] as String
    ..noLocalEventsEmail = json['noLocalEventsEmail'] as bool
    ..noNationalEventsEmail = json['noNationalEventsEmail'] as bool
    ..noNewsletterEmail = json['noNewsletterEmail'] as bool
    ..noRousseauEventsEmail = json['noRousseauEventsEmail'] as bool
    ..noVoteEmail = json['noVoteEmail'] as bool
    ..noSms = json['noSms'] as bool;
}

Map<String, dynamic> _$CurrentUserToJson(CurrentUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'statusColor': instance.statusColor,
      'slug': instance.slug,
      'createdAt': instance.createdAt?.toIso8601String(),
      'voteRightStartingCountDate':
          instance.voteRightStartingCountDate?.toIso8601String(),
      'profile': instance.profile,
      'gender': instance.gender,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'codiceFiscale': instance.codiceFiscale,
      'dateOfBirth': instance.dateOfBirth,
      'placeOfBirth': instance.placeOfBirth,
      'phoneNumber': instance.phoneNumber,
      'noLocalEventsEmail': instance.noLocalEventsEmail,
      'noNationalEventsEmail': instance.noNationalEventsEmail,
      'noNewsletterEmail': instance.noNewsletterEmail,
      'noRousseauEventsEmail': instance.noRousseauEventsEmail,
      'noVoteEmail': instance.noVoteEmail,
      'noSms': instance.noSms,
    };
