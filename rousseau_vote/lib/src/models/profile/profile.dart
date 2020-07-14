import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile();

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  String presentation;
  String curriculumActivist;
  String curriculumVitae;
  String yearOfGraduation;
  String educationalInstitute;
  String studyCourse;
  String englishLevel;
  String frenchLevel;
  String germanLevel;
  String spanishLevel;
  String qualification;
  String politicalExperiences;
  String facebookProfile;
  String twitterProfile;
  String linkedinProfile;
  int age;
  String placeOfBirth;
  String italiaCinqueStelleVolunteerFlag;
  String italiaCinqueStelleVolunteer;
  String listRepresentativeFlag;
  String listRepresentativeYear;
  String listRepresentativeComune;
  String opendayParticipantFlag;
  String opendayParticipant;
  String spokesmanM5sFlag;
  String spokesmanM5sYear;
  String spokesmanM5sInstitution;
  String villaggioRousseauParticipantFlag;
  String villaggioRousseauParticipant;
  String villaggioRousseauVolunteerFlag;
  String villaggioRousseauVolunteer;
}
