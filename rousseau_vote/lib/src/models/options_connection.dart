import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/page_info.dart';

import 'option.dart';

part 'options_connection.g.dart';

@JsonSerializable()
class OptionsConnection {
  OptionsConnection();

  factory OptionsConnection.fromJson(Map<String, dynamic> json) => _$OptionsConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$OptionsConnectionToJson(this);


  @JsonKey(fromJson: sortOptions, name: 'nodes')
  List<Option> options;
  int totalCount;
  PageInfo pageInfo;


  static List<Option> sortOptions(List optionsJson) {
    final List<Option> options = optionsJson
        ?.map((e) =>
    e == null ? null : Option.fromJson(e as Map<String, dynamic>))
        ?.toList();
    if (options != null &&
        options.isNotEmpty &&
        options[0].isEntityUserType) {
      options.shuffle();
      options.sort((Option a, Option b) {
        return b.entity.meritCount - a.entity.meritCount;
      });
    }
    return options;
  }
}