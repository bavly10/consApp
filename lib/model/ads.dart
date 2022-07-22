// To parse this JSON data, do
//
//     final ads = adsFromJson(jsonString);

import 'dart:convert';

List<Ads> adsFromJson(String str) =>
    List<Ads>.from(json.decode(str).map((x) => Ads.fromJson(x)));

String adsToJson(List<Ads> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ads {
  Ads({
    required this.id,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    required this.premium,
    required this.Name,
    required this.URLLink,
    required this.profileImage,
  });

  int id;
  DateTime? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool premium;
  String? URLLink;
  String? Name;
  ProfileImage profileImage;

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        id: json["id"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        premium: json["premium"],
        URLLink: json["URLLink"],
        Name: json["Name"],
        profileImage: ProfileImage.fromJson(json["profileImage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "published_at": publishedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "premium": premium,
        "URLLink": URLLink,
        "Name": Name,
        "profileImage": profileImage.toJson(),
      };
}

class ProfileImage {
  ProfileImage({
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
  String? provider;
  dynamic? providerMetadata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        id: json["id"],
        name: json["name"],
        alternativeText:
            json["alternativeText"] == null ? null : json["alternativeText"],
        caption: json["caption"] == null ? null : json["caption"],
        width: json["width"],
        height: json["height"],
        formats:
            json["formats"] == null ? null : Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: extValues.map![json["ext"]],
        mime: mimeValues.map![json["mime"]],
        size: json["size"] == null ? null : json["size"].toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
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
        "alternativeText": alternativeText == null ? null : alternativeText,
        "caption": caption == null ? null : caption,
        "width": width,
        "height": height,
        "formats": formats!.toJson(),
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

enum Ext { JPG }

final extValues = EnumValues({".jpg": Ext.JPG});

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

enum Mime { IMAGE_JPG, IMAGE_JPEG }

final mimeValues =
    EnumValues({"image/jpeg": Mime.IMAGE_JPEG, "image/jpg": Mime.IMAGE_JPG});

class UserName {
  UserName({
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
    this.city,
    this.address,
    this.about,
    this.forgetpass,
    this.introPrice,
    this.introLogo,
    this.introImg,
  });

  int? id;
  String? username;
  String? email;
  String? provider;
  bool? blocked;
  int? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? categories;
  int? specailst;
  String? typeIntroducer;
  String? phone;
  bool? confirmed;
  String? city;
  String? address;
  String? about;
  bool? forgetpass;
  dynamic introPrice;
  ProfileImage? introLogo;
  List<ProfileImage>? introImg;

  factory UserName.fromJson(Map<String, dynamic> json) => UserName(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        blocked: json["blocked"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categories: json["categories"],
        specailst: json["specailst"],
        typeIntroducer: json["type_introducer"],
        phone: json["phone"],
        confirmed: json["Confirmed"],
        city: json["city"],
        address: json["address"],
        about: json["about"],
        forgetpass: json["forgetpass"],
        introPrice: json["introPrice"],
        introLogo: json["intro_logo"] != null
            ? ProfileImage.fromJson(json["intro_logo"])
            : null,
        introImg: List<ProfileImage>.from(
            json["intro_img"].map((x) => ProfileImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "blocked": blocked,
        "role": role,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "categories": categories,
        "specailst": specailst,
        "type_introducer": typeIntroducer,
        "phone": phone,
        "Confirmed": confirmed,
        "city": city,
        "address": address,
        "about": about,
        "forgetpass": forgetpass,
        "introPrice": introPrice,
        "intro_logo": introLogo!.toJson(),
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
