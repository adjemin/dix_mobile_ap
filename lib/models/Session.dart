
import 'dart:convert';

import 'package:dixapp/models/Subscription.dart';
import 'package:dixapp/models/User.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Session.g.dart';

@JsonSerializable()
class Session{

  final User user;

  final Subscription subscription;

  const Session({this.user, this.subscription});

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  String toJsonString(){
    return jsonEncode(toJson());
  }

}