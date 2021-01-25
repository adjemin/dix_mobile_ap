// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) {
  return Subscription(
    id: json['id'] as int,
    name: json['name'] as String,
    free_limit: json['free_limit'] as int,
    is_totally_free: json['is_totally_free'] as bool,
    price: (json['price'] as num)?.toDouble(),
    currency_code: json['currency_code'] as String,
    currency_name: json['currency_name'] as String,
  );
}

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'free_limit': instance.free_limit,
      'is_totally_free': instance.is_totally_free,
      'price': instance.price,
      'currency_code': instance.currency_code,
      'currency_name': instance.currency_name,
    };
