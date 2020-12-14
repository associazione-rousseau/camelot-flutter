import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/geo/comune.dart';
import 'package:rousseau_vote/src/models/geo/country.dart';
import 'package:rousseau_vote/src/models/geo/municipio.dart';
import 'package:rousseau_vote/src/models/geo/provincia.dart';
import 'package:rousseau_vote/src/models/geo/regione.dart';
import 'package:rousseau_vote/src/models/interface/paginated.dart';
import 'package:rousseau_vote/src/models/profile/user_position.dart';
import 'package:rousseau_vote/src/models/residence_change_request.dart';
import 'package:rousseau_vote/src/models/profile/badge.dart';
import 'package:rousseau_vote/src/models/profile/category.dart';
import 'package:rousseau_vote/src/models/profile/participation.dart';
import 'package:rousseau_vote/src/models/profile/profile.dart';
import 'package:rousseau_vote/src/models/profile/resume_document.dart';
import 'package:rousseau_vote/src/models/profile/tag.dart';
import 'package:rousseau_vote/src/models/profile/tirendiconto_data.dart';
import 'package:rousseau_vote/src/models/profile/user_profile.dart';
import 'package:rousseau_vote/src/models/profile/user_public_subscriptions.dart';

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
  Country country;
  Regione regione;
  Provincia provincia;
  Comune comune;
  Municipio municipio;
  ResidenceChangeRequest lastResidenceChangeRequest;
  String overseaseCity;

  String get currentUserResidence => overseaseCity ?? comune?.name ?? residence;

  bool get shouldVerifyIdentity => statusColor == 'GREY' || statusColor == 'RED';

  bool get hasCompiledProfile => profile != null;

  bool get canVote {
    return statusColor == 'GREEN';
  }

  bool get pendingVerification {
    return statusColor == 'ORANGE';
  }
}
