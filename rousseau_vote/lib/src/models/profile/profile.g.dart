// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile()
    ..age = json['age'] as int
    ..placeOfBirth = json['placeOfBirth'] as String
    ..placeOfResidence = json['placeOfResidence'] == null
        ? null
        : PlaceOfResidence.fromJson(
            json['placeOfResidence'] as Map<String, dynamic>)
    ..picture = json['picture'] == null
        ? null
        : Picture.fromJson(json['picture'] as Map<String, dynamic>)
    ..presentation = json['presentation'] as String
    ..curriculumActivist = json['curriculumActivist'] as String
    ..curriculumVitae = json['curriculumVitae'] as String
    ..politicalExperiences = json['politicalExperiences'] as String
    ..studyCourse = json['studyCourse'] as String
    ..yearOfGraduation = json['yearOfGraduation'] as String
    ..qualification = json['qualification'] as String
    ..educationalInstitute = json['educationalInstitute'] as String
    ..languageLevels = (json['languageLevels'] as List)
        ?.map((e) => e == null
            ? null
            : LanguageLevel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..socialLinks = (json['socialLinks'] as List)
        ?.map((e) =>
            e == null ? null : SocialLink.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'age': instance.age,
      'placeOfBirth': instance.placeOfBirth,
      'placeOfResidence': instance.placeOfResidence,
      'picture': instance.picture,
      'presentation': instance.presentation,
      'curriculumActivist': instance.curriculumActivist,
      'curriculumVitae': instance.curriculumVitae,
      'politicalExperiences': instance.politicalExperiences,
      'studyCourse': instance.studyCourse,
      'yearOfGraduation': instance.yearOfGraduation,
      'qualification': instance.qualification,
      'educationalInstitute': instance.educationalInstitute,
      'languageLevels': instance.languageLevels,
      'socialLinks': instance.socialLinks,
    };
