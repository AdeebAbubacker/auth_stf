import 'package:json_annotation/json_annotation.dart';

part 'usermodel.g.dart'; // This will be generated automatically

@JsonSerializable()
class User {
  final String username;
  final String password;

  User({
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
