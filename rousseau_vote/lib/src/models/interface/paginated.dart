import 'package:json_annotation/json_annotation.dart';
import 'package:rousseau_vote/src/models/page_info.dart';

part 'paginated.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Paginated<T> {

  Paginated();

  factory Paginated.fromJson(Map<String, dynamic> json, T Function(Object json) fromJsonT) => _$PaginatedFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$PaginatedToJson(this, toJsonT);

  PageInfo pageInfo;
  int totalCount;
  List<T> nodes;

  void mergePreviousPage(Paginated<T> previousPage) => nodes = previousPage.nodes + nodes;

  bool hasNext() => pageInfo.hasNextPage;
  
  String afterCursor() => pageInfo.endCursor;
}
