import 'package:helpy_app/model/user_model.dart';

abstract class cons_login_Register_States {}

class consSignInUp_InitalState extends cons_login_Register_States {}

class AppAdd_Ime1_State extends cons_login_Register_States {}

class TakeImage_State extends cons_login_Register_States {}

class TakeImages_State extends cons_login_Register_States {}

class DeleteImage_State extends cons_login_Register_States {}

class DeleteImages_State extends cons_login_Register_States {}

class UploadImage_State extends cons_login_Register_States {}

class TakeImagess_State extends cons_login_Register_States {}

class TakeImagess_Error_State extends cons_login_Register_States {}

class TakechangeMedia_State extends cons_login_Register_States {}

class TakechangeBoolMedia_State extends cons_login_Register_States {}

class cons_Loading_Register extends cons_login_Register_States {}

class cons_Register_Scusess extends cons_login_Register_States {}

class cons_Register_Error extends cons_login_Register_States {
  final String error;
  cons_Register_Error(this.error);
}

class cons_Registerr_Error extends cons_login_Register_States {}

class cons_Register_final_Error extends cons_login_Register_States {}

class cons_Register_finaly_Error extends cons_login_Register_States {}

class cons_Register_firebase_Error extends cons_login_Register_States {}

class cons_Loading_login extends cons_login_Register_States {}

class cons_getuser_login extends cons_login_Register_States {}

class cons_getuser_logindone extends cons_login_Register_States {}

class cons_user_Scusess extends cons_login_Register_States {}

class cons_user_error extends cons_login_Register_States {}

class cons_Login_Scusess extends cons_login_Register_States {
  final bool confirmed;
  cons_Login_Scusess(this.confirmed);
}

class cons_Login_Error extends cons_login_Register_States {
  final LoginModel loginModel;
  cons_Login_Error(this.loginModel);
}

class cons_not_connected_net_login extends cons_login_Register_States {}

class Cons_Change_Design extends cons_login_Register_States {}

class Cons_Change_Designs extends cons_login_Register_States {}

class Cons_ChangeCity_Select extends cons_login_Register_States {}

class Cons_Change_Cat_Select extends cons_login_Register_States {}

class Cons_Change_Spec_Loading extends cons_login_Register_States {}

class Cons_Change_Spec_Select extends cons_login_Register_States {}

class Cons_Change_type_value extends cons_login_Register_States {}

class LoginChangePassSucessState extends cons_login_Register_States {}

class LoginChangePassErrorState extends cons_login_Register_States {}

class ConsAddPostUserLoadingState extends cons_login_Register_States {}

class ConsAddPostUserSucessState extends cons_login_Register_States {}

class ConsAddPostUserErrorState extends cons_login_Register_States {}

class ConImagePostSucessState extends cons_login_Register_States {}

class ConImagePostErrorState extends cons_login_Register_States {}

class NoemailErrorState extends cons_login_Register_States {}

class UserChangeState extends cons_login_Register_States {}

class UserChangestrapi extends cons_login_Register_States {}

class UploadUserFileSueeeState extends cons_login_Register_States {}

class UploadUserFileLoadingState extends cons_login_Register_States {}

class UploadUserFileErrorState extends cons_login_Register_States {}

class ChangePasswordVisibiltyState extends cons_login_Register_States {}

class AcceptPrivacyState extends cons_login_Register_States {}

class DontAcceptPrivacyState extends cons_login_Register_States {}

class ChangeCheckedState extends cons_login_Register_States {}

class UploadUserImageSucessState extends cons_login_Register_States {}

class UploadUserImageErrorState extends cons_login_Register_States {}

class LoadingChangeUserImageState extends cons_login_Register_States {}

class ChangeUserImageSuessState extends cons_login_Register_States {}

class ChangeUserImageErrorState extends cons_login_Register_States {}
class Changeprice extends cons_login_Register_States {}
