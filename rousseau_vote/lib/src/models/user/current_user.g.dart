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
    ..verified = json['verified'] as bool
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
    ..noSms = json['noSms'] as bool
    ..country = json['country'] == null
        ? null
        : ItalianGeographicalDivision.fromJson(
            json['country'] as Map<String, dynamic>)
    ..regione = json['regione'] == null
        ? null
        : ItalianGeographicalDivision.fromJson(
            json['regione'] as Map<String, dynamic>)
    ..provincia = json['provincia'] == null
        ? null
        : ItalianGeographicalDivision.fromJson(
            json['provincia'] as Map<String, dynamic>)
    ..comune = json['comune'] == null
        ? null
        : ItalianGeographicalDivision.fromJson(
            json['comune'] as Map<String, dynamic>)
    ..municipio = json['municipio'] == null
        ? null
        : ItalianGeographicalDivision.fromJson(
            json['municipio'] as Map<String, dynamic>)
    ..overseaseCity = json['overseaseCity'] as String
    ..badges = (json['badges'] as List)
        ?.map(
            (e) => e == null ? null : Badge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..lastResidenceChangeRequest = json['lastResidenceChangeRequest'] == null
        ? null
        : ResidenceChangeRequest.fromJson(
            json['lastResidenceChangeRequest'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CurrentUserToJson(CurrentUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'statusColor': instance.statusColor,
      'slug': instance.slug,
      'verified': instance.verified,
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
      'country': instance.country,
      'regione': instance.regione,
      'provincia': instance.provincia,
      'comune': instance.comune,
      'municipio': instance.municipio,
      'overseaseCity': instance.overseaseCity,
      'badges': instance.badges,
      'lastResidenceChangeRequest': instance.lastResidenceChangeRequest,
    };
