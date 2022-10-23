// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/modImage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ModImage _$$_ModImageFromJson(Map<String, dynamic> json) => _$_ModImage(
      id: json['id'] as String?,
      filename: json['filename'] as String?,
      content_type: json['content_type'] as String?,
      proxy_url: json['proxy_url'] as String?,
      url: json['url'] as String?,
      size: (json['size'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_ModImageToJson(_$_ModImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filename': instance.filename,
      'content_type': instance.content_type,
      'proxy_url': instance.proxy_url,
      'url': instance.url,
      'size': instance.size,
    };
