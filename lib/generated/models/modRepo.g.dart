// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/modRepo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ModRepo _$$_ModRepoFromJson(Map<String, dynamic> json) => _$_ModRepo(
      items: (json['items'] as List<dynamic>)
          .map((e) => ModInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toDouble(),
      lastUpdated: json['lastUpdated'] as String?,
    );

Map<String, dynamic> _$$_ModRepoToJson(_$_ModRepo instance) =>
    <String, dynamic>{
      'items': instance.items,
      'totalCount': instance.totalCount,
      'lastUpdated': instance.lastUpdated,
    };
