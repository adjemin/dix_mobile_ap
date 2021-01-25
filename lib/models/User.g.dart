// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    name: json['name'] as String,
    dial_code: json['dial_code'] as String,
    phone_number: json['phone_number'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    is_tried: json['is_tried'] as bool,
    is_paid_subscription: json['is_paid_subscription'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dial_code': instance.dial_code,
      'phone_number': instance.phone_number,
      'phone': instance.phone,
      'email': instance.email,
      'is_tried': instance.is_tried,
      'is_paid_subscription': instance.is_paid_subscription,
    };
