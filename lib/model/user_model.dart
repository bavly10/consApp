import 'dart:convert';

class LoginModel {
  int? stauts;
  String? error, token;
  UserStrapi? userClass;
  List<Datum>? message;
  List<Datum>? data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json["jwt"];
    userClass=json["user"] != null ? UserStrapi.fromJson(json["user"]): userClass = UserStrapi.fromJson(json);
  }
  LoginModel.xJson(Map<String, dynamic> json) {
    stauts = json["statusCode"];
    error = json["error"];
    message = json["message"] != null
        ? List<Datum>.from(json["message"].map((x) => Datum.fromJson(x)))
        : null;
    data = json["data"] != null
        ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
        : null;
  }

}

class Datum {
  Datum({
    this.messages,
  });

  List<Messages>? messages;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        messages: List<Messages>.from(
            json["messages"].map((x) => Messages.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Messages {
  Messages({
    this.id,
    this.message,
  });

  String? id;
  String? message;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        id: json["id"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
      };
}

UserStrapi userFromJson(String str) => UserStrapi.fromJson(json.decode(str));

String userToJson(UserStrapi data) => json.encode(data.toJson());

class UserStrapi {
  UserStrapi(
      {required this.id,
      required this.username,
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
      this.introLogo,
      this.introImg,
      this.about,
      this.posts,
      this.filesIntros,
      this.forgetpass,
      required this.introPrice});

  late int? id;
  late String username;
  String? email;
  String? provider;
  bool? blocked;
  Role? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  Categories_user? categories;
  Specailst_user? specailst;
  String? typeIntroducer;
  String? phone;
  bool? confirmed;
  String? city;
  String? address;
  String? about;
  bool? forgetpass;
  Img_user? introLogo;
  List<Img_user>? introImg;
  List<Post_user>? posts;
  List<FilesIntro>? filesIntros;
  dynamic introPrice;

  factory UserStrapi.fromJson(Map<String, dynamic> json) => UserStrapi(
        id: json["id"],
        username: json["username"],
        introPrice: json["introPrice"],
        email: json["email"],
        about: json["about"],
        provider: json["provider"],
        blocked: json["blocked"],
        role: Role.fromJson(json["role"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categories: Categories_user.fromJson(json["categories"]),
        specailst: Specailst_user.fromJson(json["specailst"]),
        typeIntroducer: json["type_introducer"],
        phone: json["phone"],
        confirmed: json["Confirmed"],
        forgetpass: json['forgetPass'],
        city: json["city"],
        address: json["address"],
        introLogo: json["intro_logo"] != null
            ? Img_user.fromJson(json["intro_logo"])
            : null,
        introImg: List<Img_user>.from(
            json["intro_img"].map((x) => Img_user.fromJson(x))),
        posts: List<Post_user>.from(
            json["posts"].map((x) => Post_user.fromJson(x))),
        filesIntros: json["filesusers"] == null
            ? null
            : List<FilesIntro>.from(
                json["filesusers"].map((x) => FilesIntro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "introPrice": introPrice,
        "provider": provider,
        "blocked": blocked,
        "role": role!.toJson(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "categories": categories!.toJson(),
        "specailst": specailst!.toJson(),
        "type_introducer": typeIntroducer,
        "phone": phone,
        "Confirmed": confirmed,
        "city": city,
        "forgetPass": forgetpass,
        "about": about,
        "address": address,
        "intro_logo": introLogo,
        "intro_img": List<dynamic>.from(introImg!.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
        "filesusers": List<dynamic>.from(filesIntros!.map((x) => x.toJson())),
      };
}

class Categories_user {
  Categories_user({
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
  Img_user? catImg;

  factory Categories_user.fromJson(Map<String, dynamic> json) =>
      Categories_user(
        id: json["id"],
        title: json["Title"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        catImg: Img_user.fromJson(json["cat_img"]),
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

class Img_user {
  Img_user({
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

  factory Img_user.fromJson(Map<String, dynamic> json) => Img_user(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats:
            json["formats"] != null ? Formats.fromJson(json["formats"]) : null,
        hash: json["hash"],
        ext: extValues.map![json["ext"]],
        mime: mimeValues.map![json["mime"]],
        // ignore: prefer_null_aware_operators
        size: json["size"] != null ? json["size"].toDouble() : null,
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
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
    this.medium,
    this.small,
    this.large,
  });

  Medium? thumbnail;
  Medium? medium;
  Medium? small;
  Medium? large;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Medium.fromJson(json["thumbnail"]),
        medium: Medium.fromJson(json["medium"]),
        small: Medium.fromJson(json["small"]),
        large: json["large"] == null ? null : Medium.fromJson(json["large"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail!.toJson(),
        "medium": medium!.toJson(),
        "small": small!.toJson(),
        "large": large!.toJson(),
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

enum Mime { IMAGE_JPEG }

final mimeValues = EnumValues({"image/jpeg": Mime.IMAGE_JPEG});

class Post_user {
  Post_user({
    this.id,
    this.content,
    this.time,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.usersId,
    this.imgPost,
  });

  int? id;
  String? content;
  String? time;
  String? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? usersId;
  Img_user? imgPost;

  factory Post_user.fromJson(Map<String, dynamic> json) => Post_user(
        id: json["id"],
        content: json["content"],
        time: json["time"],
        publishedAt: json["published_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        usersId: json["users_id"],
        imgPost: json["img_post"] == null
            ? null
            : Img_user.fromJson(json["img_post"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "time": time,
        "published_at": publishedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "users_id": usersId,
        "img_post": imgPost!.toJson(),
      };
}

class Role {
  Role({
    this.id,
    this.name,
    this.description,
    this.type,
    this.introducer,
  });

  int? id;
  String? name;
  String? description;
  String? type;
  int? introducer;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        introducer: json["introducer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
        "introducer": introducer,
      };
}

class Specailst_user {
  Specailst_user({
    this.id,
    this.specTitle,
    this.catTitle,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? specTitle;
  int? catTitle;
  DateTime? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Specailst_user.fromJson(Map<String, dynamic> json) => Specailst_user(
        id: json["id"],
        specTitle: json["Spec_title"],
        catTitle: json["cat_title"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Spec_title": specTitle,
        "cat_title": catTitle,
        "published_at": publishedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class FilesIntro {
  FilesIntro(
      {this.id,
      this.fileName,
      this.usersPermissionsUser,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.fileIntro,
      this.price});

  int? id;
  String? fileName, price;
  int? usersPermissionsUser;
  dynamic publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  File_intro? fileIntro;

  factory FilesIntro.fromJson(Map<String, dynamic> json) => FilesIntro(
        id: json["id"],
        fileName: json["filename"],
        usersPermissionsUser: json["users_permissions_user"],
        publishedAt: json["published_at"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fileIntro: File_intro.fromJson(json["filepdf"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_name": fileName,
        "users_permissions_user": usersPermissionsUser,
        "published_at": publishedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "Filepdf": fileIntro!.toJson(),
        "price": price,
      };
}

class File_intro {
  File_intro({
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
  dynamic? providerMetadata;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory File_intro.fromJson(Map<String, dynamic> json) => File_intro(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats:
            json["formats"] == null ? null : Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: extValues.map![json["ext"]],
        mime: mimeValues.map![json["mime"]],
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
        "formats": formats!.toJson(),
        "hash": hash,
        "ext": extValues.reverse[ext],
        "mime": mimeValues.reverse[mime],
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider == null ? null : providerValues.reverse[provider],
        "provider_metadata": providerMetadata,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

enum Provider { LOCAL }

final providerValues = EnumValues({"local": Provider.LOCAL});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
