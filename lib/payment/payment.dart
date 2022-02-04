import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


import 'package:helpy_app/modules/Deatils_Special/cubit/cubit.dart';
import 'package:helpy_app/modules/Deatils_Special/cubit/states.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/my_colors.dart';


class PaymentsTest extends StatelessWidget {
  final String url;
  final int id;
  PaymentsTest(this.url,this.id);

  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final cubit = ConsCubitIntro.get(context).findbyid(id);
    return BlocConsumer<ConsCubitIntro,cons_StatesIntro>(
      listener: (ctx,state){
        if(state is Cons_Payments_loading )
          {
            myToast(message: "Loading.....");
          }
        else if (state is Cons_Payments_add)
          {
            if(state.modelPayment.tran_ref==controller.text){
              myToast(message: "Let's Goooooooooooooooooooo with ${cubit.username}");
              print("done");
              ///navigate to chat with cubit
            }else {
              myToast(message: "SomeThing error!!");
            }
          }
        else if (state is Cons_Payments_error)
        {
          myToast(message:state.error);
        }
      },
      builder:(ctx,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                myTran(context,cubit.username),
                const  Padding(
                  padding:  EdgeInsets.all(8.0),
                  child:  Divider(height: 1,color: Colors.black,),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height *1,
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(url)),
                      onAjaxReadyStateChange: (controller,load)async{
                      print("restext ${load.responseText}");
                      print("XML ${load.url}");
                      print("XML ${load.responseXML}");
                      if(load.responseText!.contains("Transaction not completed")){
                        print("failed");
                        return AjaxRequestAction.PROCEED;
                      }else{
                        print("done");
                        return AjaxRequestAction.PROCEED;
                      }
                    },
                  )
                  ,),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget myTran(context,text) {
    return Form(
      key: formState,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        child: Card(
          color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(text: TextSpan(
                  text: "After Pay You will get a Transaction Number Set here to Start chat with ",
                  style: const TextStyle(color: Colors.black,fontSize: 16,height: 1.4,fontWeight: FontWeight.bold),
                  children:<TextSpan>[
                    TextSpan(
                      text:text,style: TextStyle(color: myAmber)
                    )
                  ]
                ),),
                const SizedBox(height: 15,),
                const Divider(height: 1,color: Colors.black,),
                Row(
                  children: [
                    Flexible(flex: 3,child:  My_TextFormFiled(
                      controller: controller,
                      myhintText: "Transaction Number",
                      validator: (String? s) {
                        if (s!.isEmpty) return "Number Transaction required";
                      },
                    ),),
                    const SizedBox(height: 5,),
                    Flexible(flex:2,child:Mybutton(
                        context: context,
                        onPress: () {
                          if (formState.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            ConsCubitIntro.get(context).addPay(controller.text);
                          }
                        },
                        title:const Text(
                          "Let's Go",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ), color: myAmber),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
