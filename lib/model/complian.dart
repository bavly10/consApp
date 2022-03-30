import 'package:helpy_app/model/ads.dart';
import 'package:helpy_app/model/customer_model.dart';
import 'package:helpy_app/model/user_model.dart';

class ComplianModel {
  late int id;
  late String subject;
  late String details;
  late UserName users_id;
  late CustomerModel customerid;

  ComplianModel({required this.subject, required this.details,required this.id,required this.customerid,required this.users_id});

  ComplianModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    details = json['details'];
    users_id = UserName.fromJson(json['users_id']);
    customerid = CustomerModel.fromJson(json['customerid']);

  }
}
