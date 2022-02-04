import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/model/payment.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/Deatils_Special/cubit/states.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConsCubitIntro extends Cubit<cons_StatesIntro> {
  ConsCubitIntro() : super(ConSpecial_InitalState());

  static ConsCubitIntro get(context) => BlocProvider.of(context);
  int limit=0;
  int pagnationDataLimit(){
    return limit+=2;
  }


  List<UserStrapi> specIntro=[];
  Future<void> getSpecIntro(id)async{
    emit(Cons_Loading_Special_intro());
    final url = Uri.parse("$base_api/users?_start=$limit&_limit=2&_where[specailst]=$id&_where[Confirmed]=true");
    final http.Response res = await http.get(url);
    List<dynamic> list = json.decode(res.body);
    if(res.statusCode == 200)
    {
      if(list.isEmpty) {
        emit(Cons_NoUsersFound_Special_intro());
      }
      else{
        for(var value in list){
          final pro=specIntro.indexWhere((element) => element.id==value['id']);
          if (pro >= 0) {
            specIntro[pro] = UserStrapi(
              id: value["id"],
              address: value["address"],
              city: value["city"],
              about: value["about"],
              username: value["username"],
              typeIntroducer: value["type_introducer"],
              specailst: Specailst_user.fromJson(value["specailst"]),
              introLogo: value["intro_logo"] == null ? null : Img_user.fromJson(
                  value["intro_logo"]),
              posts: (value['posts'] as List<dynamic>).map((e) => Post_user(
                      content: e["content"],
                      publishedAt: e["published_at"],
                      imgPost: Img_user.fromJson(e['img_post'])
                  )).toList(),
              filesIntros:(value['files_intros']as List<dynamic>).map((e) =>FilesIntro(
                fileIntro: File_intro.fromJson(e["file_intro"]),
                fileName:e["file_name"],
              )).toList(),
            );
          }
          else {
            specIntro.add(UserStrapi(
              id: value["id"],
              address: value["address"],
              city: value["city"],
              about: value["about"],
              username: value["username"],
              typeIntroducer: value["type_introducer"],
              specailst: Specailst_user.fromJson(value["specailst"]),
              introLogo: value["intro_logo"] == null ? null : Img_user.fromJson(
                  value["intro_logo"]),
              posts: (value['posts'] as List<dynamic>).map((e) =>
                  Post_user(
                      content: e["content"],
                      publishedAt: e["published_at"],
                      imgPost:e['img_post']==null?null:Img_user.fromJson(e['img_post'])
                  )
              ).toList(),
              filesIntros:(value['filesusers']as List<dynamic>).map((e) =>FilesIntro(
                fileIntro: File_intro.fromJson(e["filepdf"]),
                fileName:e["filename"],
              )).toList(),
            ));
            emit(Cons_newSuccess_Special_intro());
          }
        }
      }
    }
    else if (res.statusCode ==500){
      ///do Something
      emit(Cons_ErrorServer_Special_intro());
    }
    else{
      emit(Cons_Error_Special_intro());
    }
  }


  UserStrapi findbyid(int id) {
    return specIntro.firstWhere((element) => element.id == id);
  }

  ////////////////////////////payment/////////////////

  // Future<PaymentSdkConfigurationDetails> generateConfig({name,email,phone,addressLine,descprtioncart,cartid,amount}) async {
  //   var billingDetails = BillingDetails(name, email,
  //       phone, addressLine, "EG", "dubai", "dubai", "12345");
  //   var shippingDetails = ShippingDetails("John Smith", "email@domain.com",
  //       "+97311111111", "st. 12", "ae", "dubai", "dubai", "12345");
  //   List<PaymentSdkAPms> apms = [];
  //   apms.add(PaymentSdkAPms.STC_PAY);
  //   var configuration = PaymentSdkConfigurationDetails(
  //       profileId: "83652",
  //       serverKey: "SWJNBBRGLD-J2L9JG2DNT-N9NHKGKTG6",
  //       clientKey: "CHKMPN-K2BV6M-BP6TMD-BKDKVD",
  //       cartId: cartid,
  //       cartDescription: descprtioncart,
  //       merchantName: "Flowers Store",
  //       screentTitle: "Pay with Card",
  //       amount: amount,
  //       showBillingInfo: true,
  //       forceShippingInfo: false,
  //       currencyCode: "EGP",
  //       transactionType: PaymentSdkTransactionType.SALE,
  //       merchantCountryCode: "EG",
  //       billingDetails: billingDetails,
  //       shippingDetails: shippingDetails,
  //       alternativePaymentMethods: apms);
  //   configuration.showBillingInfo=false;
  //   var theme = IOSThemeConfigurations();
  //   theme.logoImage = "assets/logo.png";
  //   configuration.iOSThemeConfigurations = theme;
  //   return configuration;
  // }
  // Future<void> payPressed({name,email,phone,addressLine,descprtioncart,cartid,amount}) async {
  //   FlutterPaytabsBridge.startCardPayment(await generateConfig(name:name,email:email ,phone:phone,addressLine: addressLine,descprtioncart: descprtioncart,cartid:cartid,amount:amount), (event) {
  //     emit(Cons_Payment_Loading());
  //       if (event["status"] == "success") {
  //         print("done");
  //         emit(Cons_Payment_Scusess());
  //         var transactionDetails = event["data"];
  //         print(transactionDetails);
  //       } else if (event["status"] == "error") {
  //         print("error");
  //         emit(Cons_Payment_Error(event['message']));
  //       } else if (event["status"] == "event") {
  //         print("event");
  //         emit(Cons_Payment_event());
  //       }
  //   });
  //   //    onPressed: () {
  //   //                         cons_Cubit.get(context).payPressed(name: "bavly naguib",amount: 50.0,email: "bavly.asd@as.com",phone: "5465465456",
  //   //                           cartid:"adwda231312" ,descprtioncart: "adwajdhawj 12dawdwa",addressLine: "dwadj ajwdhwjad awduw hudwahd",);
  //   //                       },
  // }

  getPay({name,email,phone,amount,user}) async{
    emit(Cons_Payment_Loading());
    final url=Uri.parse("https://secure-egypt.paytabs.com/payment/request");
    Map<String,String> headers={
      "Content-Type": 'application/json',
      'authorization': 'SBJNBBRGMW-J2L9JG2DLH-9K6WHZRGZL'
    };
    Map<String,dynamic> body={
      "profile_id":83652,
      "tran_type": "sale",
      "tran_class": "ecom" ,
      "cart_id":"4244b9fd-c7e9-4f16-8d3c-4fe7bf6c48ca",
      "cart_description": "${user+ "Cons App"}",
      "cart_currency": "EGP",
      "cart_amount": amount,
      "customer_details": {
        "name": name,
        "email": email,
        "phone": phone,
        "street1": "404, 11th st, void",
        "city": "Cairo",
        "state": "EG",
        "country": "EG",
      },
      "framed":true,
      "hide_shipping":true
    };
    var response= await http.post(url, headers: headers, body:jsonEncode(body));
    if (response.statusCode == 200) {
      var jdson=jsonDecode(response.body);
      final loadeddata= jdson['redirect_url'];
      print(response.body);
      emit(Cons_Payment_done(loadeddata));
      return true;
    }
    else if(response.statusCode ==400){
      var jdsonn = jsonDecode(response.body);
      emit(Cons_Payment_notdone(jdsonn.toString()));
      return false;
    }
    else{

    }
  }

  ModelPayment? modelPayment;
  Future<void> addPay(trancontroller)async {
    emit(Cons_Payments_loading());
    final url=Uri.parse("https://secure-egypt.paytabs.com/payment/query");
    Map<String,String> headers={
      "Content-Type": 'application/json',
      'authorization': 'SBJNBBRGMW-J2L9JG2DLH-9K6WHZRGZL'
    };
    Map<String,dynamic> body={
      "profile_id":83652,
       "tran_ref":trancontroller,
    };
    var response= await http.post(url, headers: headers, body:jsonEncode(body));
    if (response.statusCode == 200) {
      var jdson=jsonDecode(response.body);
      modelPayment=ModelPayment.fromJson(jdson);
      print(response.body);
      emit(Cons_Payments_add(modelPayment!));
    }
    else if(response.statusCode ==400){
      var jdsonn = jsonDecode(response.body);
      emit(Cons_Payments_error(jdsonn['message'].toString()));
    }
  }
}