import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/user/profile.dart';
import 'package:rousseau_vote/src/models/profile/badge.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  String id;
  String fullName;
  String slug;
  String overseaseCity;
  Profile profile;
  List<Badge> badges;
  @JsonKey(name: '__typename')
  String type;
  Set<int> _merits;

  String get residence => overseaseCity ?? profile.placeOfResidence.comuneName;

  Set<int> get merits {
    _merits ??= _calculateMerits();
    return _merits;
  }

  int get meritCount => merits.length;

  bool hasBadge(int badgeNumber) => merits.contains(badgeNumber);

  Set<int> _calculateMerits() {
    final Set<int> merits = <int>{};
    if(badges == null) {
      return merits;
    }
    for (Badge badge in badges) {
      merits.add(badge.merit);
    }
    return merits;
  }

  String getProfilePictureUrl() {
    if(profile == null || profile.picture == null) {
      return null;
    }
    return profile.picture.originalUrl;
  }

}