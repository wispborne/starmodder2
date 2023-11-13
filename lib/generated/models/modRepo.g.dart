// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/modRepo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ModRepoImpl _$$ModRepoImplFromJson(Map<String, dynamic> json) =>
    _$ModRepoImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => ModInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toDouble(),
      lastUpdated: json['lastUpdated'] as String?,
    );

Map<String, dynamic> _$$ModRepoImplToJson(_$ModRepoImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'totalCount': instance.totalCount,
      'lastUpdated': instance.lastUpdated,
    };
