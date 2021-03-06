import 'package:helpy_app/model/customer_model.dart';

abstract class Customer_States {}

class consSignInUpCustomer_InitalState extends Customer_States {}

class RegisterLoadingState extends Customer_States {}

class RegisterSuccessState extends Customer_States {}

class RegisterErrorState extends Customer_States {}

class RegisterFinalErrorState extends Customer_States {}

class RegisterErrorFirebaseState extends Customer_States {}

class RegisterErrorXState extends Customer_States {}

class LoginLoadingState extends Customer_States {}

class LoginSuccessState extends Customer_States {}

class LoginErrorState extends Customer_States {}

class CustomerChangeState extends Customer_States {}

class CustomerSuccessState extends Customer_States {}

class CustomerLoadinggState extends Customer_States {}

class CustomerErrorState extends Customer_States {
  final String error;
  CustomerErrorState(this.error);
}

class CustomerLoadingState extends Customer_States {}

class CustomerCreateChatState extends Customer_States {}

class ConGetCoustomersLoadingState extends Customer_States {}

class ConGetCoustomersSucessState extends Customer_States {}

class ConGetCoustomersErrorState extends Customer_States {}

class LoginCustomerChangePassSucessState extends Customer_States {}

class LoginCustomerChangePassErrorState extends Customer_States {}

class UpdateCustomerDataSucessState extends Customer_States {}

class UpdateCustomerDataErrorState extends Customer_States {}

class UploadCustomerImageSucessState extends Customer_States {}

class UploadCustomerImageErrorState extends Customer_States {}

class ChangeCustomerImageSuessState extends Customer_States {}

class ChangeCustomerImageErrorState extends Customer_States {}

class TakeImageCustomer_State extends Customer_States {}

class DeleteImageCustomer_State extends Customer_States {}

class LoadingChangeCustomerImage extends Customer_States {}

class EmailCustomerisExitState extends Customer_States {}

class EmailCustomerisNotExitState extends Customer_States {}

class CustomerPasswordIsChangeState extends Customer_States {}

class CustomerPasswordIsNotChange extends Customer_States {}

class AddUserComplianSueeeState extends Customer_States {}

class AddUserComplianErrorState extends Customer_States {}

class AddUserComplianLoadingState extends Customer_States {}

class ChangeSelectedDropDown extends Customer_States {}
