import 'package:freezed_annotation/freezed_annotation.dart';

part 'image.freezed.dart';
part 'image.g.dart';

@freezed
class Image with _$Image {
  const factory Image({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String alternativeText,
    @Default('') String caption,
    @Default(0) int width,
    @Default(0) int height,
    @Default(Formats()) Formats formats,
    @Default('') String hash,
    @Default('') String ext,
    @Default('') String mime,
    @Default(0.0) double size,
    @Default('') String url,
    @Default('') String previewUrl,
    @Default('') String provider,
    DateTime? createdAt,
    DateTime? updatedAt,
    // required String providerMetadata,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}

@freezed
class Formats with _$Formats {
  const factory Formats({
    @Default(Small()) Small thumbnail,
    @Default(Small()) Small small,
  }) = _Formats;

  factory Formats.fromJson(Map<String, dynamic> json) =>
      _$FormatsFromJson(json);
}

@freezed
class Small with _$Small {
  const factory Small({
    @Default('') String name,
    @Default('') String hash,
    @Default('') String ext,
    @Default('') String mime,
    @Default('') String path,
    @Default(0) int width,
    @Default(0) int height,
    @Default(0.0) double size,
    @Default('') String url,
  }) = _Small;

  factory Small.fromJson(Map<String, dynamic> json) => _$SmallFromJson(json);
}
