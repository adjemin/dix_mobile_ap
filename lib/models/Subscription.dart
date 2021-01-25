import 'package:json_annotation/json_annotation.dart';

part 'Subscription.g.dart';

@JsonSerializable()
class Subscription{

  final int id;
  final String name;
  final int free_limit;
  final bool is_totally_free;
  final double price;
  final String currency_code;
  final String currency_name;

  const Subscription({this.id,
    this.name,
    this.free_limit,
    this.is_totally_free,
    this.price,
    this.currency_code,
    this.currency_name});

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

}