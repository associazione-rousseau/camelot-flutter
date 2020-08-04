import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/profile/badge.dart';
import 'package:rousseau_vote/src/models/residence_change_request.dart';
import 'package:rousseau_vote/src/models/user/profile.dart';
import 'package:rousseau_vote/src/widgets/user/residence_request_widget.dart';

part 'current_user.g.dart';

@JsonSerializable()
class CurrentUser {
  CurrentUser();

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);

  String id;
  String email;
  String fullName;
  String statusColor;
  String slug;
  bool verified;
  DateTime createdAt;
  DateTime voteRightStartingCountDate;
  Profile profile;
  String gender;
  String firstName;
  String lastName;
  String codiceFiscale;
  String dateOfBirth;
  String placeOfBirth;
  String phoneNumber;
  bool noLocalEventsEmail;
  bool noNationalEventsEmail;
  bool noNewsletterEmail;
  bool noRousseauEventsEmail;
  bool noVoteEmail;
  bool noSms;
  ItalianGeographicalDivision country;
  ItalianGeographicalDivision regione;
  ItalianGeographicalDivision provincia;
  ItalianGeographicalDivision comune;
  ItalianGeographicalDivision municipio;
  String overseaseCity;
  List<Badge> badges;
  ResidenceChangeRequest lastResidenceChangeRequest;

  String get residence {
    if(overseaseCity != null) {
      return overseaseCity;
    }
    return profile != null && profile.placeOfResidence != null ?
        profile.placeOfResidence.comuneName
        : '';
  }

  bool get shouldVerifyIdentity => statusColor == 'GREY' || statusColor == 'RED';

  String getProfilePictureUrl() {
    if (profile == null || profile.picture == null) {
      return null;
    }
    return profile.picture.originalUrl;
  }

  bool get canVote {
    return statusColor == 'GREEN';
  }

  bool get pendingVerification {
    return statusColor == 'ORANGE';
  }
}
