import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/events/event_date.dart';

import 'event_place.dart';

part 'event.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class Event {
  Event();

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  String title;
  String subtitle;
  String campaign;
  @JsonKey(name: 'image')
  String squareImage;
  String coverImage;
  String permalink;
  String marker;
  @JsonKey(name: 'description')
  String newDescription;
  @JsonKey(name: '0')
  String legacyDescription;
  String slug;
  String signupUrl;

  @JsonKey(fromJson: parseSignupStatus)
  SignupStatus signupStatus;

  @JsonKey(fromJson: parseDates)
  List<EventDate> dates;

  EventPlace place;

  String get location => place != null ? place.formattedAddress : 'ONLINE';
  String get description =>
      newDescription == null || newDescription.isEmpty ? legacyDescription : newDescription;

  bool get canSignup => signupStatus == SignupStatus.ACTIVE;
  bool get isSoldout => signupStatus == SignupStatus.SOLDOUT;

  static List<EventDate> parseDates(Map<String, dynamic> datesJson) {
    final List<EventDate> dates = <EventDate>[];
    for(String key in datesJson.keys) {
      dates.add(EventDate.fromJson(datesJson[key]));
    }
    return dates;
  }

  static SignupStatus parseSignupStatus(String signupStatus) {
    switch(signupStatus) {
      case 'active': return SignupStatus.ACTIVE;
      case 'disabled': return SignupStatus.DISABLED;
      case 'soldout': return SignupStatus.SOLDOUT;
      case 'closed': return SignupStatus.CLOSED;
    }
    return SignupStatus.UNKNOWN;
  }
}

enum SignupStatus {
  ACTIVE, DISABLED, SOLDOUT, CLOSED, UNKNOWN
}
