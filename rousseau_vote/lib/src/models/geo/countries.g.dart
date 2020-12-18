// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Countries _$CountriesFromJson(Map<String, dynamic> json) {
  return Countries()
    ..countriesConnection = json['countriesConnection'] == null
        ? null
        : Paginated.fromJson(
            json['countriesConnection'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : Country.fromJson(value as Map<String, dynamic>));
}

Map<String, dynamic> _$CountriesToJson(Countries instance) => <String, dynamic>{
      'countriesConnection': instance.countriesConnection?.toJson(
        (value) => value,
      ),
    };
