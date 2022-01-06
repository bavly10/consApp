import 'package:helpy_app/model/customer_model.dart';

abstract class Customer_States{}
class consSignInUpCustomer_InitalState extends Customer_States{}

class RegisterLoadingState extends Customer_States{}
class RegisterSuccessState extends Customer_States{}
class RegisterErrorState extends Customer_States{}
class RegisterFinalErrorState extends Customer_States{}
class RegisterErrorFirebaseState extends Customer_States{}
class RegisterErrorXState extends Customer_States{}


class LoginLoadingState extends Customer_States{}
class LoginSuccessState extends Customer_States{}
class LoginErrorState extends Customer_States{}

class CustomerChangeState extends Customer_States{}
class CustomerSuccessState extends Customer_States{}
class CustomerLoadinggState extends Customer_States{}
class CustomerErrorState extends Customer_States{
  final String error;
  CustomerErrorState(this.error);
}



class CustomerLoadingState extends Customer_States{}
class CustomerCreateChatState extends Customer_States{}









