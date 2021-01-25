// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubscriptionResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionResult _$SubscriptionResultFromJson(Map<String, dynamic> json) {
  return SubscriptionResult(
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['subscription'] == null
        ? null
        : Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
    json['transaction'] == null
        ? null
        : InvoicePayment.fromJson(json['transaction'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SubscriptionResultToJson(SubscriptionResult instance) =>
    <String, dynamic>{
      'user': instance.user,
      'subscription': instance.subscription,
      'transaction': instance.transaction,
    };
