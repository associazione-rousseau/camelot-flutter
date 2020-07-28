// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryList _$CountryListFromJson(Map<String, dynamic> json) {
  return CountryList()
    ..countries = (json['countries'] as List)
        ?.map((e) => e == null
            ? null
            : ItalianGeographicalDivision.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CountryListToJson(CountryList instance) =>
    <String, dynamic>{
      'countries': instance.countries,
    };
