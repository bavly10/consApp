import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpy_app/Cubit/states.dart';
import 'package:helpy_app/model/ads.dart';
import 'package:helpy_app/model/categories_model.dart';
import 'package:helpy_app/model/specailsts_model.dart';
import 'package:helpy_app/modules/MainScreen/aboutus.dart';
import 'package:helpy_app/modules/MainScreen/Ads/ads.dart';
import 'package:helpy_app/modules/MainScreen/home_services.dart';
import 'package:helpy_app/modules/User/login/main_login.dart';

import 'package:helpy_app/shared/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';

import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ConsCubit extends Cubit<cons_States> {
  ConsCubit() : super(Con_InitalState());
  static ConsCubit get(context) => BlocProvider.of(context);

  // ignore: non_constant_identifier_names
  Locale? locale_cubit;
  String? lang;
  static bool xtranslate = false;
  var token;
  void changeLang(lang) async {
    Locale currentLocale = await setLocale(lang.lang_Code);
    changLocale(currentLocale);
  }

  changLocale(Locale currentLocale) {
    locale_cubit = currentLocale;
  }

  Future<Locale> locale(String lang) async {
    switch (lang) {
      case "en":
        xtranslate = false;
        locale_cubit = Locale(lang, "US");
        break;
      case "ar":
        xtranslate = true;
        locale_cubit = Locale(lang, "SA");

        break;
      default:
        locale_cubit = const Locale("ar", "SA");
    }
    emit(cons_Change_Language());
    return locale_cubit!;
  }

  Future<Locale> setLocale(String langCode) async {
    await CashHelper.putData("locale", langCode);
    return locale(langCode);
  }

  Future<Locale> getLocale() async {
    lang = CashHelper.getData("locale");
    return locale(lang!);
  }

  bool isConnected = true;
  Future<bool> checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
        emit(cons_ChecknetSucsess_locale());
      }
    } on SocketException catch (_) {
      isConnected = false;
      emit(cons_ChecknetError_locale());
    }
    return isConnected;
  }

  int currentindex = 0;
  List<Widget> screen = [
    const HomeServices(),
    AdsScreen(),
    // const AboutUs(),
    MyHomePage(),

    Main_login(),
  ];

  void changeIndex(int index) {
    currentindex = index;
    emit(cons_ChangeIndexTabs());
  }

  ///////
  List<Categories> mycat = [];
  List<Specailsts> myspec = [];
  List<Ads> myads = [];
  List<Ads> myads2 = [];
  Future getCategories() async {
    emit(Cons_Loading_Cate());
    final url = Uri.parse("$base_api/Categories");
    final http.Response res = await http.get(url);
    List ex = json.decode(res.body);
    if (res.statusCode == 200) {
      if (ex.isEmpty) {
        print("no more Data");
      } else {
        for (var item in ex) {
          final pro = mycat.indexWhere((element) => element.id == item['id']);
          if (pro >= 0) {
            mycat[pro] = Categories(
              id: item["id"],
              title: item["Title"],
              catImg: CatImgs.fromJson(item["cat_img"]),
            );
          } else {
            mycat.add(Categories(
              id: item["id"],
              title: item["Title"],
              catImg: CatImgs.fromJson(item["cat_img"]),
            ));
            emit(Cons_Success_Cate());
          }
        }
        emit(Cons_Success_Cate());
        return mycat;
      }
    } else if (res.statusCode == 500) {
      print("error 500");
    }
  }

  Future getSpecailsts() async {
    myspec = [];
    final url = Uri.parse("$base_api/Specailsts");
    final http.Response res = await http.get(url);
    try {
      List<dynamic> ex = json.decode(res.body);
      if (res.statusCode == 200) {
        for (var item in ex) {
          Specailsts e = Specailsts(
            id: item["id"],
            specTitle: item["Spec_title"],
            catTitle: CatTitle.fromJson(item["cat_title"]),
          );
          myspec.add(e);
        }
        emit(Cons_Success_Special());
        return myspec;
      } else {}
    } on FormatException catch (e) {
      emit(Cons_Error_Special(e.toString()));
    } catch (error) {
      rethrow;
    }
  }

  late double code;
  void randomCode() {
    var rng = Random();
    code = rng.nextDouble() * 10000;
    while (code < 1000) {
      code *= 10;
    }
    emit(ConsCreateCode());
    print(code.toInt());
  }

  Future<void> sendOTPMail({String? email, int? code}) async {
    emit(cons_SendTOP_Loading());
    // ad5ol 3la link da 34an a3ml less secure app
    //https://accounts.google.com/signin/v2/challenge/ootp?continue=https%3A%2F%2Fmyaccount.google.com%2Flesssecureapps&service=accountsettings&osid=1&rart=ANgoxcfTLMpngpOkgfrP8_mFAWTF5K1NFzO1Ur96D9oPOS3PhKJ70Kf6ZfeBtD_28wi-ZgUyq7iTCP_rTPgWcDWW0uI1onOnGw&TL=AM3QAYZhMX1-97NVHmhOPfmFNouvPCHl3Z7ITGzYqtRbFdqiJZGCn3fdG2ck96lo&flowName=GlifWebSignIn&cid=4&flowEntry=ServiceLogin
    String username = 'projectt104@gmail.com';
    String password = 'bavly704353511';
    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'bavly')
      ..recipients.add('$email')
      //..ccRecipients.addAll(['bavly.naguib@yahoo.com', 'bebonagi2@gmail.com'])
      //..bccRecipients.add(Address('bebonagi2@gmail.com'))
      ..subject = 'Verification code 😀'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h1>My Company </h1>\n<p>Hey Your Code Verification is <h1 style='color:green'>$code</h1> </p>";
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      emit(cons_SendTOP_Scusess());
    } on MailerException catch (e) {
      emit(cons_SendTOP_Error());
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE
    var connection = PersistentConnection(smtpServer);
    await connection.close();
  }

  Future<void> getAds() async {
    emit(Cons_Loading_Ads());
    final url = Uri.parse("$base_api/Ads");
    final http.Response res = await http.get(url);
    List ads = json.decode(res.body);
    if (res.statusCode == 200) {
      for (var item in ads) {
        final pro = myads.indexWhere((element) => element.id == item['id']);
        if (item['premium'] == true) {
          if (pro >= 0) {
            myads[pro] = (Ads(
              id: item['id'],
              Name: item['Name'],
              URLLink: item['URLLink'],
              profileImage: ProfileImage.fromJson(item['profileImage']),
              premium: item['premium'],
            ));
            emit(Cons_noNewData_Ads());
            print("no data new");
          } else {
            myads.add(Ads(
              id: item['id'],
              Name: item['Name'],
              URLLink: item['URLLink'],
              profileImage: ProfileImage.fromJson(item['profileImage']),
              premium: item['premium'],
            ));
          }
        } else if (item['premium'] == false) {
          final pros = myads2.indexWhere((element) => element.id == item['id']);
          if (pros >= 0) {
            myads2[pros] = (Ads(
              id: item['id'],
              Name: item['Name'],
              URLLink: item['URLLink'],
              profileImage: ProfileImage.fromJson(item['profileImage']),
              premium: item['premium'],
            ));
            emit(Cons_noNewData_Ads());
            print("no data new");
          } else {
            myads2.add(Ads(
              id: item['id'],
              Name: item['Name'],
              URLLink: item['URLLink'],
              profileImage: ProfileImage.fromJson(item['profileImage']),
              premium: item['premium'],
            ));
          }
        }
      }
      emit(Cons_Success_Ads());
    } else if (res.statusCode == 500) {
      emit(Cons_Error_Ads(e.toString()));
    }
  }

  String? customerToken;
  String? customerID;
  String? userToken;
  int? userID;
  int? customerIDStrapi;
  String? localeLang;
  String? custTokenDevice;
  String? userTokenDevice;

  void getMyShared() {
    customerToken = CashHelper.getData("tokenCustomer");
    customerID = CashHelper.getData("cust_id");
    userToken = CashHelper.getData("userToken");
    userID = CashHelper.getData("userId");
    customerIDStrapi = CashHelper.getData("customer_idStrapi");
    localeLang = CashHelper.getData("locale");
    userTokenDevice = CashHelper.getData("userToken");
    custTokenDevice = CashHelper.getData("customerToken");
  }

  String? localID;
  void getID() {
    if (customerID == null) {
      localID = userID.toString();
    } else {
      localID = customerID;
    }
  }

  final HttpClient httpClient = HttpClient();
  final String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
  String fcmKey =
      "AAAAwm87A2Y:APA91bFL6sSEa93uK9wGraq90kNEM6-Zsa98-1lgGnMB2S2ou1feNkwZc9_am9DW1msAxHgbZG6GacFsLOEr8wREHR7VtFpyRyWauf2WEjzuItCSF4p3V0NYjk8hEV6ZzwNypUO3NSdV";

  Future<void> sendFcm({
    required String title,
    required String body,
    String? nameSender,
    String? fcmToken,
  }) async {
    var response = await http.post(Uri.parse(fcmUrl),
        body: jsonEncode({
          "to": fcmToken,
          "priority": "high",
          "notification": {
            "title": title,
            "body": nameSender! + body,
            "sound": "default"
          },
          "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "sound": "default",
          },
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$fcmKey '
        });

    if (response.statusCode == 200) {
      print('Helloooooooooooo');
      print(response.body.toString());
    } else {
      print('Noooooooooooooo');
      print(response.reasonPhrase);
    }
  }

  void sendAddingNotification({name, id, tittle, body, context, nameSender}) {
    FirebaseFirestore.instance
        .collection(name)
        .doc(id.toString())
        .collection('tokens')
        .doc(id.toString())
        .get()
        .then((value) {
      ConsCubit.get(context).sendFcm(
          title: tittle,
          body: body,
          nameSender: nameSender ?? "",
          fcmToken: value.get('token'));
    });
  }
}
