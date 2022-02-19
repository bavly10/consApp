// To parse this JSON data, do
//
//     final ads = adsFromJson(jsonString);

import 'dart:convert';

List<AdsModel> adsFromJson(String str) =>
    List<AdsModel>.from(json.decode(str).map((x) => AdsModel.fromJson(x)));

String adsToJson(List<AdsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdsModel {
  AdsModel({
    required this.id,
    required this.username,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    required this.profileImage,
  });

  int id;
  String username;
  late String description;
  DateTime? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  late AdsImage profileImage;

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        id: json["id"],
        username: json["username"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profileImage: AdsImage.fromJson(json["profileImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "published_at": publishedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "profileImage": profileImage.toJson(),
      };
}

class AdsImage {
  AdsImage({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    this.hash,
    this.mime,
    this.size,
    this.url,
    this.previewUrl,
    this.provider,
    this.providerMetadata,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? alternativeText;
  String? caption;
  int? width;
  int? height;
  Formats? formats;
  String? hash;
  String? mime;
  double? size;
  String? url;
  dynamic? previewUrl;
  String? provider;
  dynamic? providerMetadata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AdsImage.fromJson(Map<String, dynamic> json) => AdsImage(
        id: json["id"],
        name: json["name"],
        alternativeText:
            json["alternativeText"] == null ? null : json["alternativeText"],
        caption: json["caption"] == null ? null : json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromJson(json["formats"]),
        hash: json["hash"],
        mime: json["mime"],
        size: json["size"].toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText == null ? null : alternativeText,
        "caption": caption == null ? null : caption,
        "width": width,
        "height": height,
        "formats": formats!.toJson(),
        "hash": hash,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Formats {
  Formats({
    this.thumbnail,
  });

  Thumbnail? thumbnail;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail!.toJson(),
      };
}

class Thumbnail {
  Thumbnail({
    this.name,
    this.hash,
    this.ext,
    this.mime,
    this.width,
    this.height,
    this.size,
    this.path,
    this.url,
  });

  String? name;
  String? hash;
  String? ext;
  String? mime;
  int? width;
  int? height;
  double? size;
  dynamic? path;
  String? url;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        name: json["name"],
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "hash": hash,
        "mime": mime,
        "ext": ext,
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
      };
}
