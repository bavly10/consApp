abstract class cons_StatesIntro{}
class ConSpecial_InitalState extends cons_StatesIntro{}


class Cons_Success_Special_intro extends cons_StatesIntro{}
class Cons_Loading_Special_intro extends cons_StatesIntro{}
class Cons_newSuccess_Special_intro extends cons_StatesIntro{}
class Cons_NoUsersFound_Special_intro extends cons_StatesIntro{}
class Cons_ErrorServer_Special_intro extends cons_StatesIntro{}
class Cons_Error_Special_intro extends cons_StatesIntro{}
class Cons_Scroll_Special_intro extends cons_StatesIntro{}
class Cons_findid_intro extends cons_StatesIntro{}


class Cons_Payment_Loading extends cons_StatesIntro{}

class Cons_Payment_Scusess extends cons_StatesIntro{}
class Cons_Payment_Error extends cons_StatesIntro{
  final String error;

  Cons_Payment_Error(this.error);
}
class Cons_Payment_event extends cons_StatesIntro{
}

class Cons_Payment_done extends cons_StatesIntro{
  final String url;

  Cons_Payment_done(this.url);
}
class Cons_Payment_notdone extends cons_StatesIntro{
  final String error;

  Cons_Payment_notdone(this.error);
}

