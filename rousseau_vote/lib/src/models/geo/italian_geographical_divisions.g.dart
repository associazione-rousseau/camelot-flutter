// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'italian_geographical_divisions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItalianGeographicalDivisions _$ItalianGeographicalDivisionsFromJson(
    Map<String, dynamic> json) {
  return ItalianGeographicalDivisions()
    ..italianGeographicalDivisions =
        json['italianGeographicalDivisions'] == null
            ? null
            : Paginated.fromJson(
                json['italianGeographicalDivisions'] as Map<String, dynamic>,
                (value) => value == null
                    ? null
                    : ItalianGeographicalDivision.fromJson(
                        value as Map<String, dynamic>));
}

Map<String, dynamic> _$ItalianGeographicalDivisionsToJson(
        ItalianGeographicalDivisions instance) =>
    <String, dynamic>{
      'italianGeographicalDivisions':
          instance.italianGeographicalDivisions?.toJson(
        (value) => value,
      ),
    };
