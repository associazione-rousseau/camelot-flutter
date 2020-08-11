import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/residence_change_request.dart';
import 'package:rousseau_vote/src/models/profile/badge.dart';
import 'package:rousseau_vote/src/models/profile/category.dart';
import 'package:rousseau_vote/src/models/profile/profile.dart';
import 'package:rousseau_vote/src/models/profile/tag.dart';
import 'package:rousseau_vote/src/models/profile/user_positions.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';

part 'current_user.g.dart';

@JsonSerializable()
class CurrentUser extends UserProfile {
  CurrentUser();

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);

  String email;
  String statusColor;
  bool verified;
  DateTime createdAt;
  DateTime voteRightStartingCountDate;
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
  ResidenceChangeRequest lastResidenceChangeRequest;

  bool get shouldVerifyIdentity => statusColor == 'GREY' || statusColor == 'RED';

  bool get hasCompiledProfile => profile != null;

  bool get canVote {
    return statusColor == 'GREEN';
  }

  bool get pendingVerification {
    return statusColor == 'ORANGE';
  }
}
