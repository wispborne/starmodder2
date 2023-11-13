import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/modImage.freezed.dart';
part '../generated/models/modImage.g.dart';

@freezed
class ModImage with _$ModImage {
  factory ModImage({
    final String? id,
    final String? filename,
    final String? content_type,
    final String? proxy_url,
    final String? url,
    final double? size,
  }) = _ModImage;

  factory ModImage.fromJson(Map<String, Object?> json) =>
      _$ModImageFromJson(json);
}
