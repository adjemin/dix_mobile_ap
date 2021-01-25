// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    subscription: json['subscription'] == null
        ? null
        : Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'user': instance.user,
      'subscription': instance.subscription,
    };
