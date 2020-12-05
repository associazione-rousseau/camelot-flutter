// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileSearch _$ProfileSearchFromJson(Map<String, dynamic> json) {
  return ProfileSearch()
    ..profiles = json['profiles'] == null
        ? null
        : Paginated.fromJson(
            json['profiles'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : User.fromJson(value as Map<String, dynamic>));
}

Map<String, dynamic> _$ProfileSearchToJson(ProfileSearch instance) =>
    <String, dynamic>{
      'profiles': instance.profiles?.toJson(
        (value) => value,
      ),
    };
