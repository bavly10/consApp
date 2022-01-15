class CustomerModel {
  final String username, email,phone;
  CustomerModel({
    required this.username,
        required this.email,
        required this.phone});

   factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
      );
   void deleteJson()=>CustomerModel(username: '', email: '', phone: '');
}
