import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/user/picture.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {

  Profile();

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  Picture picture;
  
}
