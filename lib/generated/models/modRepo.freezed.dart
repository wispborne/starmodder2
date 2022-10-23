// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../../models/modRepo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ModRepo _$ModRepoFromJson(Map<String, dynamic> json) {
  return _ModRepo.fromJson(json);
}

/// @nodoc
mixin _$ModRepo {
  List<ModInfo> get items => throw _privateConstructorUsedError;
  double? get totalCount => throw _privateConstructorUsedError;
  String? get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ModRepoCopyWith<ModRepo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModRepoCopyWith<$Res> {
  factory $ModRepoCopyWith(ModRepo value, $Res Function(ModRepo) then) =
      _$ModRepoCopyWithImpl<$Res, ModRepo>;
  @useResult
  $Res call({List<ModInfo> items, double? totalCount, String? lastUpdated});
}

/// @nodoc
class _$ModRepoCopyWithImpl<$Res, $Val extends ModRepo>
    implements $ModRepoCopyWith<$Res> {
  _$ModRepoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalCount = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ModInfo>,
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ModRepoCopyWith<$Res> implements $ModRepoCopyWith<$Res> {
  factory _$$_ModRepoCopyWith(
          _$_ModRepo value, $Res Function(_$_ModRepo) then) =
      __$$_ModRepoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ModInfo> items, double? totalCount, String? lastUpdated});
}

/// @nodoc
class __$$_ModRepoCopyWithImpl<$Res>
    extends _$ModRepoCopyWithImpl<$Res, _$_ModRepo>
    implements _$$_ModRepoCopyWith<$Res> {
  __$$_ModRepoCopyWithImpl(_$_ModRepo _value, $Res Function(_$_ModRepo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalCount = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$_ModRepo(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ModInfo>,
      totalCount: freezed == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ModRepo implements _ModRepo {
  _$_ModRepo(
      {required final List<ModInfo> items, this.totalCount, this.lastUpdated})
      : _items = items;

  factory _$_ModRepo.fromJson(Map<String, dynamic> json) =>
      _$$_ModRepoFromJson(json);

  final List<ModInfo> _items;
  @override
  List<ModInfo> get items {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final double? totalCount;
  @override
  final String? lastUpdated;

  @override
  String toString() {
    return 'ModRepo(items: $items, totalCount: $totalCount, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ModRepo &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_items), totalCount, lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ModRepoCopyWith<_$_ModRepo> get copyWith =>
      __$$_ModRepoCopyWithImpl<_$_ModRepo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ModRepoToJson(
      this,
    );
  }
}

abstract class _ModRepo implements ModRepo {
  factory _ModRepo(
      {required final List<ModInfo> items,
      final double? totalCount,
      final String? lastUpdated}) = _$_ModRepo;

  factory _ModRepo.fromJson(Map<String, dynamic> json) = _$_ModRepo.fromJson;

  @override
  List<ModInfo> get items;
  @override
  double? get totalCount;
  @override
  String? get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$_ModRepoCopyWith<_$_ModRepo> get copyWith =>
      throw _privateConstructorUsedError;
}
