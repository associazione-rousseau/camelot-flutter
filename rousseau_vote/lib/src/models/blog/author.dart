import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Author {
  Author();

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  String name;
  String avatar;
  String rousseauSlug;
}
