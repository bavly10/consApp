class CustomerModel {
  final String username, email, phone;
  String? image;
  CustomerModel(
      {required this.username,
        required this.email,
        required this.phone,
        this.image});

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
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

  void deleteJson() => CustomerModel(username: '', email: '', phone: '');
}
