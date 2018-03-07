import 'package:json_annotation/json_annotation.dart';
/// This allows our `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'user.g.dart';


@JsonSerializable()

class User extends Object with _$UserSerializerMixin {

  User(this.id,this.name, this.location);

  int id;
  String name;
  String location;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. We pass the map to the generated _$UserFromJson constructor.
  /// The constructor is named after the source class, in this case User.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}