// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BackupResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackupResult _$BackupResultFromJson(Map<String, dynamic> json) {
  return BackupResult(
    backup: (json['backup'] as List)
        ?.map((e) =>
            e == null ? null : DixContact.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BackupResultToJson(BackupResult instance) =>
    <String, dynamic>{
      'backup': instance.backup,
    };
