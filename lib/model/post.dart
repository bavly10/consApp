class PostModel {
  late int id;
  late String content;
  String? time;
  String? image;
  dynamic users_id;
  PostModel({required this.content, this.image, this.time});

  PostModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    content = json['content'];
    time = json['time'];
    image = json['image'];
    users_id = json['users_id'];
  }
  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'time': time,
      'image': image,
      'users_id': users_id,
    };
  }
}
