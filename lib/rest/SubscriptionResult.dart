import 'package:dixapp/models/InvoicePayment.dart';
import 'package:dixapp/models/Subscription.dart';
import 'package:dixapp/models/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SubscriptionResult.g.dart';

@JsonSerializable()
class SubscriptionResult{

  final User user;
  final Subscription subscription;
  final InvoicePayment transaction;

  const SubscriptionResult(this.user, this.subscription, this.transaction);

  factory SubscriptionResult.fromJson(Map<String, dynamic> json) => _$SubscriptionResultFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionResultToJson(this);


}