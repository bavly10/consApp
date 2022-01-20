abstract class cons_States{}
class Con_InitalState extends cons_States{}

class TakeImage_State extends cons_States{}
class cons_delete_image extends cons_States{}

class cons_myenteris extends cons_States{}

class cons_Change_Language extends cons_States{}
class cons_Change_Language_locale extends cons_States{}
class cons_ChecknetSucsess_locale extends cons_States{}
class cons_ChecknetError_locale extends cons_States{}

class cons_ChangeIndexTabs extends cons_States{}






class Cons_Success_Cate extends cons_States{}
class Cons_Loading_Cate extends cons_States{}
class Cons_Error_Cate extends cons_States{
  final String error;

  Cons_Error_Cate(this.error);
}
class Cons_Success_Special extends cons_States{}


class Cons_Error_Special extends cons_States{
  final String error;
  Cons_Error_Special(this.error);

}
class Cons_Error_Special_intro extends cons_States{
  final String error;
  Cons_Error_Special_intro(this.error);


}
class Cons_Success_Introducer extends cons_States{}

class Cons_Error_Introducer extends cons_States{
  final String error;
  Cons_Error_Introducer(this.error);

}
class ConsCreateCode extends cons_States{


}

class cons_SendTOP_Scusess extends cons_States{}
class cons_SendTOP_Loading extends cons_States{}
class cons_SendTOP_Error extends cons_States{}


class Cons_Success_Ads extends cons_States{}
class Cons_noNewData_Ads extends cons_States{}
class Cons_Loading_Ads extends cons_States{}
class Cons_Error_Ads extends cons_States{
  final String error;

  Cons_Error_Ads(this.error);
}