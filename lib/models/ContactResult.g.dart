// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContactResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactResult _$ContactResultFromJson(Map<String, dynamic> json) {
  return ContactResult(
    contacts: (json['contacts'] as List)
        ?.map((e) =>
            e == null ? null : DixContact.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalContactCount: json['totalContactCount'] as int,
    moovContactCount: json['moovContactCount'] as int,
    mtnContactCount: json['mtnContactCount'] as int,
    orangeContactCount: json['orangeContactCount'] as int,
    totalNumberCount: json['totalNumberCount'] as int,
    totalConvertedNumberCount: json['totalConvertedNumberCount'] as int,
    totalNoneConvertedNumberCount: json['totalNoneConvertedNumberCount'] as int,
  );
}

Map<String, dynamic> _$ContactResultToJson(ContactResult instance) =>
    <String, dynamic>{
      'contacts': instance.contacts,
      'totalContactCount': instance.totalContactCount,
      'moovContactCount': instance.moovContactCount,
      'mtnContactCount': instance.mtnContactCount,
      'orangeContactCount': instance.orangeContactCount,
      'totalNumberCount': instance.totalNumberCount,
      'totalConvertedNumberCount': instance.totalConvertedNumberCount,
      'totalNoneConvertedNumberCount': instance.totalNoneConvertedNumberCount,
    };
