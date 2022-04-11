import 'dart:convert';

List<Specailsts> specailstsFromJson(String str) =>
    List<Specailsts>.from(json.decode(str).map((x) => Specailsts.fromJson(x)));

String specailstsToJson(List<Specailsts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Specailsts {
  Specailsts({
    required this.id,
    required this.specTitle,
    required this.catTitle,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.users,
  });

  late int id;
  late String specTitle;
  late CatTitle catTitle;
  DateTime? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<User_spec>? users;

  factory Specailsts.fromJson(Map<String, dynamic> json) => Specailsts(
        id: json["id"],
        specTitle: json["Spec_title"],
        catTitle: CatTitle.fromJson(json["cat_title"]),
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        users: List<User_spec>.from(
            json["users"].map((x) => User_spec.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Spec_title": specTitle,
        "cat_title": catTitle.toJson(),
        "published_at": publishedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class CatTitle {
  CatTitle({
    this.id,
    this.title,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.catImg,
  });

  int? id;
  String? title;
  DateTime? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  CatImg? catImg;

  factory CatTitle.fromJson(Map<String, dynamic> json) => CatTitle(
        id: json["id"],
        title: json["Title"],
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        catImg: CatImg.fromJson(json["cat_img"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Title": title,
        "published_at": publishedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "cat_img": catImg!.toJson(),
      };
}

class CatImg {
  CatImg({
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
  Ext? ext;
  Mime? mime;
  double? size;
  String? url;
  dynamic? previewUrl;
  Provider? provider;
  dynamic providerMetadata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CatImg.fromJson(Map<String, dynamic> json) => CatImg(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats:
            json["formats"] == null ? null : Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: json["ext"] == null ? null : extValues.map![json["ext"]],
        mime: json["mime"] == null ? null : mimeValues.map![json["mime"]],
        size: json["size"].toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"] == null
            ? null
            : providerValues.map![json["provider"]],
        providerMetadata: json["provider_metadata"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats == null ? null : formats!.toJson(),
        "hash": hash,
        "ext": ext == null ? null : extValues.reverse[ext],
        "mime": mime == null ? null : mimeValues.reverse[mime],
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider == null ? null : providerValues.reverse[provider],
        "provider_metadata": providerMetadata,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

enum Ext { JPG, PNG }

final extValues = EnumValues({".jpg": Ext.JPG, ".png": Ext.PNG});

class Formats {
  Formats({
    this.thumbnail,
    this.large,
    this.medium,
    this.small,
  });

  Medium? thumbnail;
  Medium? large;
  Medium? medium;
  Medium? small;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Medium.fromJson(json["thumbnail"]),
        large: json["large"] == null ? null : Medium.fromJson(json["large"]),
        medium: json["medium"] == null ? null : Medium.fromJson(json["medium"]),
        small: Medium.fromJson(json["small"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail!.toJson(),
        "large": large == null ? null : large!.toJson(),
        "medium": medium!.toJson(),
        "small": small!.toJson(),
      };
}

class Medium {
  Medium({
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
  Ext? ext;
  Mime? mime;
  int? width;
  int? height;
  double? size;
  dynamic? path;
  String? url;

  factory Medium.fromJson(Map<String, dynamic> json) => Medium(
        name: json["name"],
        hash: json["hash"],
        ext: extValues.map![json["ext"]],
        mime: mimeValues.map![json["mime"]],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
      };
}

enum Mime { IMAGE_JPEG, IMAGE_PNG }

final mimeValues =
    EnumValues({"image/jpeg": Mime.IMAGE_JPEG, "image/png": Mime.IMAGE_PNG});

enum Provider { LOCAL }

final providerValues = EnumValues({"local": Provider.LOCAL});

class User_spec {
  User_spec({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.blocked,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.categories,
    this.specailst,
    this.typeIntroducer,
    this.phone,
    this.confirmed,
    this.introLogo,
    this.introImg,
  });

  int? id;
  String? username;
  String? email;
  Provider? provider;
  bool? blocked;
  int? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? categories;
  int? specailst;
  String? typeIntroducer;
  String? phone;
  bool? confirmed;
  CatImg? introLogo;
  List<CatImg>? introImg;

  factory User_spec.fromJson(Map<String, dynamic> json) => User_spec(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: providerValues.map![json["provider"]],
        blocked: json["blocked"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categories: json["categories"],
        specailst: json["specailst"],
        typeIntroducer: json["type_introducer"],
        phone: json["phone"],
        confirmed: json["Confirmed"],
        introLogo: json["intro_logo"] == null
            ? null
            : CatImg.fromJson(json["intro_logo"]),
        introImg:
            List<CatImg>.from(json["intro_img"].map((x) => CatImg.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": providerValues.reverse[provider],
        "blocked": blocked == null ? null : blocked,
        "role": role,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "categories": categories,
        "specailst": specailst,
        "type_introducer": typeIntroducer,
        "phone": phone,
        "Confirmed": confirmed,
        "intro_logo": introLogo == null ? null : introLogo!.toJson(),
        "intro_img": List<dynamic>.from(introImg!.map((x) => x.toJson())),
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
