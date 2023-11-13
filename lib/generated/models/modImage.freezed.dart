// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../models/modImage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ModImage _$ModImageFromJson(Map<String, dynamic> json) {
  return _ModImage.fromJson(json);
}

/// @nodoc
mixin _$ModImage {
  String? get id => throw _privateConstructorUsedError;
  String? get filename => throw _privateConstructorUsedError;
  String? get content_type => throw _privateConstructorUsedError;
  String? get proxy_url => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  double? get size => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ModImageCopyWith<ModImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModImageCopyWith<$Res> {
  factory $ModImageCopyWith(ModImage value, $Res Function(ModImage) then) =
      _$ModImageCopyWithImpl<$Res, ModImage>;
  @useResult
  $Res call(
      {String? id,
      String? filename,
      String? content_type,
      String? proxy_url,
      String? url,
      double? size});
}

/// @nodoc
class _$ModImageCopyWithImpl<$Res, $Val extends ModImage>
    implements $ModImageCopyWith<$Res> {
  _$ModImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? filename = freezed,
    Object? content_type = freezed,
    Object? proxy_url = freezed,
    Object? url = freezed,
    Object? size = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      filename: freezed == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      content_type: freezed == content_type
          ? _value.content_type
          : content_type // ignore: cast_nullable_to_non_nullable
              as String?,
      proxy_url: freezed == proxy_url
          ? _value.proxy_url
          : proxy_url // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModImageImplCopyWith<$Res>
    implements $ModImageCopyWith<$Res> {
  factory _$$ModImageImplCopyWith(
          _$ModImageImpl value, $Res Function(_$ModImageImpl) then) =
      __$$ModImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? filename,
      String? content_type,
      String? proxy_url,
      String? url,
      double? size});
}

/// @nodoc
class __$$ModImageImplCopyWithImpl<$Res>
    extends _$ModImageCopyWithImpl<$Res, _$ModImageImpl>
    implements _$$ModImageImplCopyWith<$Res> {
  __$$ModImageImplCopyWithImpl(
      _$ModImageImpl _value, $Res Function(_$ModImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? filename = freezed,
    Object? content_type = freezed,
    Object? proxy_url = freezed,
    Object? url = freezed,
    Object? size = freezed,
  }) {
    return _then(_$ModImageImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      filename: freezed == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
      content_type: freezed == content_type
          ? _value.content_type
          : content_type // ignore: cast_nullable_to_non_nullable
              as String?,
      proxy_url: freezed == proxy_url
          ? _value.proxy_url
          : proxy_url // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModImageImpl implements _ModImage {
  _$ModImageImpl(
      {this.id,
      this.filename,
      this.content_type,
      this.proxy_url,
      this.url,
      this.size});

  factory _$ModImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModImageImplFromJson(json);

  @override
  final String? id;
  @override
  final String? filename;
  @override
  final String? content_type;
  @override
  final String? proxy_url;
  @override
  final String? url;
  @override
  final double? size;

  @override
  String toString() {
    return 'ModImage(id: $id, filename: $filename, content_type: $content_type, proxy_url: $proxy_url, url: $url, size: $size)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.content_type, content_type) ||
                other.content_type == content_type) &&
            (identical(other.proxy_url, proxy_url) ||
                other.proxy_url == proxy_url) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, filename, content_type, proxy_url, url, size);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModImageImplCopyWith<_$ModImageImpl> get copyWith =>
      __$$ModImageImplCopyWithImpl<_$ModImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModImageImplToJson(
      this,
    );
  }
}

abstract class _ModImage implements ModImage {
  factory _ModImage(
      {final String? id,
      final String? filename,
      final String? content_type,
      final String? proxy_url,
      final String? url,
      final double? size}) = _$ModImageImpl;

  factory _ModImage.fromJson(Map<String, dynamic> json) =
      _$ModImageImpl.fromJson;

  @override
  String? get id;
  @override
  String? get filename;
  @override
  String? get content_type;
  @override
  String? get proxy_url;
  @override
  String? get url;
  @override
  double? get size;
  @override
  @JsonKey(ignore: true)
  _$$ModImageImplCopyWith<_$ModImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
