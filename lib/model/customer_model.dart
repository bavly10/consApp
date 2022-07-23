class CustomerModel {
  final String username, email, phone;
  String? image;
  dynamic walletPoint = 0.0;
  CustomerModel(
      {required this.username,
      required this.email,
      required this.phone,
      this.image,
      this.walletPoint});

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      image: json["imageCustomer"],
      walletPoint: json["WalletPoint"]);
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'walletPoint': walletPoint,
      "imageCustomer": image,
    };
  }

  void deleteJson() => CustomerModel(username: '', email: '', phone: '');
}
