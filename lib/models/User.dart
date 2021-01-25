import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User{

  final int id;
  final String name;
  final String dial_code;
  final String phone_number;
  final String phone;
  final String email;
  final bool is_tried;
  final bool is_paid_subscription;

  const User({this.id, this.name, this.dial_code, this.phone_number, this.phone,
    this.email, this.is_tried, this.is_paid_subscription});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}