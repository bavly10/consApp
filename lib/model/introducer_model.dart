class IntroducerModel {
  final String username, email, phone;
  String? image;
  IntroducerModel(
      {required this.username,
      required this.email,
      required this.phone,
      this.image});

  factory IntroducerModel.fromJson(Map<String, dynamic> json) =>
      IntroducerModel(
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
      );
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
    };
  }

  void deleteJson() => IntroducerModel(username: '', email: '', phone: '');
}
