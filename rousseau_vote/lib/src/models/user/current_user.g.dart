// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) {
  return CurrentUser()
    ..id = json['id'] as String
    ..slug = json['slug'] as String
    ..accountType = json['accountType'] as String
    ..fullName = json['fullName'] as String
    ..lastName = json['lastName'] as String
    ..firstName = json['firstName'] as String
    ..gender = json['gender'] as String
    ..isSubscripted = json['isSubscripted'] as bool
    ..subscriptionCount = json['subscriptionCount'] as int
    ..subscriptions = json['subscriptions'] == null
        ? null
        : Paginated.fromJson(
            json['subscriptions'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : Subscription.fromJson(value as Map<String, dynamic>))
    ..userPublicSubscriptions = json['userPublicSubscriptions'] == null
        ? null
        : Paginated.fromJson(
            json['userPublicSubscriptions'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : User.fromJson(value as Map<String, dynamic>))
    ..profile = json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>)
    ..participations = json['participations'] == null
        ? null
        : Paginated.fromJson(
            json['participations'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : Participation.fromJson(value as Map<String, dynamic>))
    ..resumeDocument = json['resumeDocument'] == null
        ? null
        : ResumeDocument.fromJson(
            json['resumeDocument'] as Map<String, dynamic>)
    ..badges = (json['badges'] as List)
        ?.map(
            (e) => e == null ? null : Badge.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..userPositions = (json['userPositions'] as List)
        ?.map((e) =>
            e == null ? null : UserPosition.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..category = json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>)
    ..tags = (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..tirendiconto = json['tirendiconto'] == null
        ? null
        : TirendicontoData.fromJson(
            json['tirendiconto'] as Map<String, dynamic>)
    ..email = json['email'] as String
    ..statusColor = json['statusColor'] as String
    ..verified = json['verified'] as bool
    ..createdAt = json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String)
    ..voteRightStartingCountDate = json['voteRightStartingCountDate'] == null
        ? null
        : DateTime.parse(json['voteRightStartingCountDate'] as String)
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
        : Country.fromJson(json['country'] as Map<String, dynamic>)
    ..regione = json['regione'] == null
        ? null
        : Regione.fromJson(json['regione'] as Map<String, dynamic>)
    ..provincia = json['provincia'] == null
        ? null
        : Provincia.fromJson(json['provincia'] as Map<String, dynamic>)
    ..comune = json['comune'] == null
        ? null
        : Comune.fromJson(json['comune'] as Map<String, dynamic>)
    ..municipio = json['municipio'] == null
        ? null
        : Municipio.fromJson(json['municipio'] as Map<String, dynamic>)
    ..lastResidenceChangeRequest = json['lastResidenceChangeRequest'] == null
        ? null
        : ResidenceChangeRequest.fromJson(
            json['lastResidenceChangeRequest'] as Map<String, dynamic>)
    ..overseaseCity = json['overseaseCity'] as String;
}

Map<String, dynamic> _$CurrentUserToJson(CurrentUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'accountType': instance.accountType,
      'fullName': instance.fullName,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'gender': instance.gender,
      'isSubscripted': instance.isSubscripted,
      'subscriptionCount': instance.subscriptionCount,
      'subscriptions': instance.subscriptions?.toJson(
        (value) => value,
      ),
      'userPublicSubscriptions': instance.userPublicSubscriptions?.toJson(
        (value) => value,
      ),
      'profile': instance.profile,
      'participations': instance.participations?.toJson(
        (value) => value,
      ),
      'resumeDocument': instance.resumeDocument,
      'badges': instance.badges,
      'userPositions': instance.userPositions,
      'category': instance.category,
      'tags': instance.tags,
      'tirendiconto': instance.tirendiconto,
      'email': instance.email,
      'statusColor': instance.statusColor,
      'verified': instance.verified,
      'createdAt': instance.createdAt?.toIso8601String(),
      'voteRightStartingCountDate':
          instance.voteRightStartingCountDate?.toIso8601String(),
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
      'lastResidenceChangeRequest': instance.lastResidenceChangeRequest,
      'overseaseCity': instance.overseaseCity,
    };
