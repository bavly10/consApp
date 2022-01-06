// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<Categories> categoriesFromJson(String str) => List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  Categories({
   required this.id,
    required this.title,
     this.publishedAt,
      this.createdAt,
      this.updatedAt,
    required   this.catImg,
  });

  late int id;
  late String title;
   DateTime? publishedAt;
   DateTime? createdAt;
   DateTime? updatedAt;
  late  CatImgs catImg;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json["id"],
    title: json["Title"],
    publishedAt: DateTime.parse(json["published_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    catImg: CatImgs.fromJson(json["cat_img"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Title": title,
    "published_at": publishedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "cat_img": catImg.toJson(),
  };
}

class CatImgs {
  CatImgs({
    this.id,
    this.name,
    this.alternativeText,
    this.caption,
    this.width,
    this.height,
    this.formats,
    this.hash,
    this.ext,
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
  String? ext;
  String? mime;
  double? size;
  String? url;
  dynamic? previewUrl;
  String? provider;
  dynamic? providerMetadata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CatImgs.fromJson(Map<String, dynamic> json) => CatImgs(
    id: json["id"],
    name: json["name"],
    alternativeText: json["alternativeText"],
    caption: json["caption"],
    width: json["width"],
    height: json["height"],
    formats: Formats.fromJson(json["formats"]),
    hash: json["hash"],
    ext: json["ext"],
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
    "alternativeText": alternativeText,
    "caption": caption,
    "width": width,
    "height": height,
    "formats": formats!.toJson(),
    "hash": hash,
    "ext": ext,
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
    "ext": ext,
    "mime": mime,
    "width": width,
    "height": height,
    "size": size,
    "path": path,
    "url": url,
  };
}
