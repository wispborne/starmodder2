// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/modInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ModInfo _$$_ModInfoFromJson(Map<String, dynamic> json) => _$_ModInfo(
      name: json['name'] as String?,
      authorsList: (json['authorsList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      gameVersionReq: json['gameVersionReq'] as String?,
      dateTimeCreated: json['dateTimeCreated'] as String?,
      images: (json['images'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ModImage.fromJson(e as Map<String, dynamic>)),
      ),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sources:
          (json['sources'] as List<dynamic>?)?.map((e) => e as String).toList(),
      urls: (json['urls'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      summary: json['summary'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$_ModInfoToJson(_$_ModInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'authorsList': instance.authorsList,
      'gameVersionReq': instance.gameVersionReq,
      'dateTimeCreated': instance.dateTimeCreated,
      'images': instance.images,
      'categories': instance.categories,
      'sources': instance.sources,
      'urls': instance.urls,
      'summary': instance.summary,
      'description': instance.description,
    };
