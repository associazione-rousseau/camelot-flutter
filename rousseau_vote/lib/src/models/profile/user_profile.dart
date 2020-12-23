import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/models/interface/paginated.dart';
import 'package:rousseau_vote/src/models/profile/badge.dart';
import 'package:rousseau_vote/src/models/profile/category.dart';
import 'package:rousseau_vote/src/models/profile/participation.dart';
import 'package:rousseau_vote/src/models/profile/profile.dart';
import 'package:rousseau_vote/src/models/profile/resume_document.dart';
import 'package:rousseau_vote/src/models/profile/tag.dart';
import 'package:rousseau_vote/src/models/profile/tirendiconto_data.dart';
import 'package:rousseau_vote/src/models/profile/user_position.dart';
import 'package:rousseau_vote/src/models/profile/user_public_subscriptions.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/models/user/subscription.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  UserProfile();

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  String id;
  String slug;
  String accountType;
  String fullName;
  String lastName;
  String firstName;
  String gender;
  bool isSubscripted;
  int subscriptionCount;
  Paginated<Subscription> subscriptions;
  Paginated<User> userPublicSubscriptions;
  Profile profile;
  Paginated<Participation> participations;
  ResumeDocument resumeDocument;
  List<Badge> badges;
  List<UserPosition> userPositions;
  Category category;
  List<Tag> tags;
  TirendicontoData tirendiconto;

  String get residence =>
          profile?.placeOfResidence?.overseaseCity ??
              profile?.placeOfResidence?.comuneName ??
          '';

  User get firstSubscriber => subscriptions?.nodes != null && subscriptions.nodes.isNotEmpty ? subscriptions.nodes[0].user : null;
  User get firstSubscribed => userPublicSubscriptions?.nodes != null && userPublicSubscriptions.nodes.isNotEmpty ? userPublicSubscriptions.nodes[0] : null;
  int get subscribedCount => userPublicSubscriptions?.totalCount ?? 0;

  String get profilePictureUrl {
    if (profile == null || profile.picture == null) {
      return null;
    }
    return profile.picture.originalUrl;
  }

  bool get isBlogAuthor => profile?.isBlogAuthor;

  String get resumeUrl {
    if (resumeDocument == null || resumeDocument.files == null || resumeDocument.files.isEmpty) {
      return null;
    }
    return resumeDocument.files[0].originalUrl;
  }

  String get url => '$ROUSSEAU_PUBLIC_PROFILE_URL/$slug';

  bool get female => gender == 'F';
  bool get male => gender == 'M';
}
