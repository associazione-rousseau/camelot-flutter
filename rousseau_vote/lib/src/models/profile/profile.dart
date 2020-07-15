import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/user/picture.dart';

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
  bool italiaCinqueStelleVolunteerFlag;
  String italiaCinqueStelleVolunteer;
  bool listRepresentativeFlag;
  String listRepresentativeYear;
  String listRepresentativeComune;
  bool opendayParticipantFlag;
  String opendayParticipant;
  bool spokesmanM5sFlag;
  String spokesmanM5sYear;
  String spokesmanM5sInstitution;
  bool villaggioRousseauParticipantFlag;
  String villaggioRousseauParticipant;
  bool villaggioRousseauVolunteerFlag;
  String villaggioRousseauVolunteer;
  Picture picture;
}
