import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starmodder2/models/modInfo.dart';

part '../generated/models/modRepo.freezed.dart';
part '../generated/models/modRepo.g.dart';

@freezed
class ModRepo with _$ModRepo {
  factory ModRepo({
    required final List<ModInfo> items,
    final double? totalCount,
    final String? lastUpdated,
  }) = _ModRepo;

  factory ModRepo.fromJson(Map<String, Object?> json) =>
      _$ModRepoFromJson(json);
}
