import 'package:freezed_annotation/freezed_annotation.dart';

import '../search.dart';
import 'modImage.dart';

part '../generated/models/modInfo.freezed.dart';
part '../generated/models/modInfo.g.dart';

@freezed
class ModInfo with _$ModInfo {
  factory ModInfo({
    final String? name,
    final List<String>? authorsList,
    final String? gameVersionReq,
    final String? dateTimeCreated,
    final Map<String, ModImage>? images,
    final List<String>? categories,
    final List<String>? sources,
    final Map<String, String>? urls,
    final String? summary,
    final String? description,
  }) = _ModInfo;

  factory ModInfo.fromJson(Map<String, Object?> json) => _$ModInfoFromJson(json);

  /// Private constructor required for freezed to allow adding custom methods and properties.
  ModInfo._();

  late final List<String> searchTags = createSearchTags(this);
}
