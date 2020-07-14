// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile()
    ..presentation = json['presentation'] as String
    ..curriculumActivist = json['curriculumActivist'] as String
    ..curriculumVitae = json['curriculumVitae'] as String
    ..yearOfGraduation = json['yearOfGraduation'] as String
    ..educationalInstitute = json['educationalInstitute'] as String
    ..studyCourse = json['studyCourse'] as String
    ..englishLevel = json['englishLevel'] as String
    ..frenchLevel = json['frenchLevel'] as String
    ..germanLevel = json['germanLevel'] as String
    ..spanishLevel = json['spanishLevel'] as String
    ..qualification = json['qualification'] as String
    ..politicalExperiences = json['politicalExperiences'] as String
    ..facebookProfile = json['facebookProfile'] as String
    ..twitterProfile = json['twitterProfile'] as String
    ..linkedinProfile = json['linkedinProfile'] as String
    ..age = json['age'] as int
    ..placeOfBirth = json['placeOfBirth'] as String
    ..italiaCinqueStelleVolunteerFlag =
        json['italiaCinqueStelleVolunteerFlag'] as String
    ..italiaCinqueStelleVolunteer =
        json['italiaCinqueStelleVolunteer'] as String
    ..listRepresentativeFlag = json['listRepresentativeFlag'] as String
    ..listRepresentativeYear = json['listRepresentativeYear'] as String
    ..listRepresentativeComune = json['listRepresentativeComune'] as String
    ..opendayParticipantFlag = json['opendayParticipantFlag'] as String
    ..opendayParticipant = json['opendayParticipant'] as String
    ..spokesmanM5sFlag = json['spokesmanM5sFlag'] as String
    ..spokesmanM5sYear = json['spokesmanM5sYear'] as String
    ..spokesmanM5sInstitution = json['spokesmanM5sInstitution'] as String
    ..villaggioRousseauParticipantFlag =
        json['villaggioRousseauParticipantFlag'] as String
    ..villaggioRousseauParticipant =
        json['villaggioRousseauParticipant'] as String
    ..villaggioRousseauVolunteerFlag =
        json['villaggioRousseauVolunteerFlag'] as String
    ..villaggioRousseauVolunteer = json['villaggioRousseauVolunteer'] as String
    ..picture = json['picture'] == null
        ? null
        : Picture.fromJson(json['picture'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'presentation': instance.presentation,
      'curriculumActivist': instance.curriculumActivist,
      'curriculumVitae': instance.curriculumVitae,
      'yearOfGraduation': instance.yearOfGraduation,
      'educationalInstitute': instance.educationalInstitute,
      'studyCourse': instance.studyCourse,
      'englishLevel': instance.englishLevel,
      'frenchLevel': instance.frenchLevel,
      'germanLevel': instance.germanLevel,
      'spanishLevel': instance.spanishLevel,
      'qualification': instance.qualification,
      'politicalExperiences': instance.politicalExperiences,
      'facebookProfile': instance.facebookProfile,
      'twitterProfile': instance.twitterProfile,
      'linkedinProfile': instance.linkedinProfile,
      'age': instance.age,
      'placeOfBirth': instance.placeOfBirth,
      'italiaCinqueStelleVolunteerFlag':
          instance.italiaCinqueStelleVolunteerFlag,
      'italiaCinqueStelleVolunteer': instance.italiaCinqueStelleVolunteer,
      'listRepresentativeFlag': instance.listRepresentativeFlag,
      'listRepresentativeYear': instance.listRepresentativeYear,
      'listRepresentativeComune': instance.listRepresentativeComune,
      'opendayParticipantFlag': instance.opendayParticipantFlag,
      'opendayParticipant': instance.opendayParticipant,
      'spokesmanM5sFlag': instance.spokesmanM5sFlag,
      'spokesmanM5sYear': instance.spokesmanM5sYear,
      'spokesmanM5sInstitution': instance.spokesmanM5sInstitution,
      'villaggioRousseauParticipantFlag':
          instance.villaggioRousseauParticipantFlag,
      'villaggioRousseauParticipant': instance.villaggioRousseauParticipant,
      'villaggioRousseauVolunteerFlag': instance.villaggioRousseauVolunteerFlag,
      'villaggioRousseauVolunteer': instance.villaggioRousseauVolunteer,
      'picture': instance.picture,
    };
