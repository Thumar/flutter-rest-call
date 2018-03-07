// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => new User(
    json['id'] as int, json['name'] as String, json['location'] as String);

abstract class _$UserSerializerMixin {
  int get id;
  String get name;
  String get location;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, 'name': name, 'location': location};
}
