import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/model/customer_model.dart';
import 'package:helpy_app/modules/MainScreen/ads.dart';
import 'package:helpy_app/modules/customer/Chat/chats_screen.dart';
import 'package:helpy_app/modules/customer/cubit/state.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/customer/main.dart';
import 'package:helpy_app/modules/customer/taps/customer_category.dart';
import 'package:helpy_app/modules/customer/taps/profile/profile.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CustomerCubit extends Cubit<Customer_States> {

  CustomerCubit() : super(consSignInUpCustomer_InitalState());
  static CustomerCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;
  late var myid;
  final _auth = FirebaseAuth.instance;
  late UserCredential authres;
  late String customerImage;
  int currentindex = 0;
  late String tokenCustomer;
  String? myCustomerId;
  final picker = ImagePicker();
  var pickedFile;
  File? imagee;
  CustomerModel? model;
  int? id;

  List<Widget> screen = [
    const CustomerCategory(),
    ChatsScreen(),
     AdsScreen(),
    const ProfileScreen(),
  ];

  void changeIndex(int index) {
    currentindex = index;
    emit(CustomerChangeState());
  }


  Future getImageBloc(ImageSource src) async {
    pickedFile = await picker.pickImage(source: src, imageQuality: 50);
    if (pickedFile != null) {
      imagee = File(pickedFile.path);
      emit(TakeImageCustomer_State());
      print("image selected");
    } else {
      print("no image selected");
    }
  }
  deleteImageBlocLogin() {
    imagee = null;
    emit(DeleteImageCustomer_State());
    print("image Deleted");
  }




  Future<void>register({required String username, required String email, required String password, required String phone}) async {
    emit(RegisterLoadingState());
    late var response;
    final url = Uri.parse("$base_api/Customers");
    Map<String, String> headrs = {'Accept': 'application/json'};
    Map<String, dynamic> body = {
      'username': username,
      'email': email,
      'password': password,
      "phone": phone,
    };
    try {
      authres = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection("customers")
          .doc(authres.user!.uid)
          .set({
        'username': username,
        'email': email,
        "phone": phone,
        "userid": authres.user!.uid,
      }).then((value) async {
        response = await http.post(url, headers: headrs, body: body);
        if (response.statusCode == 200) {
          var jdson = jsonDecode(response.body);
          myid = jdson["id"];
          print(response.body);
          emit(RegisterSuccessState());
          return true;
        } else if (response.statusCode == 400) {
          emit(RegisterErrorState());
          return false;
        } else {
          emit(RegisterFinalErrorState());
        }
      });
    } on FirebaseException catch (y) {
      emit(RegisterErrorFirebaseState());
      throw y;
    } catch (e) {
      emit(RegisterErrorXState());
    }
  }

  Future<void> signin(String email, String pass) async {
    emit(LoginLoadingState());
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAKbxexl8OzpCBcBj-_Gp5iyM_8mVcumYo");
    try {
      final res = await http.post(url,
          body: json.encode({
            'email': email,
            'password': pass,
            'returnSecureToken': true,
          }));
      final resdata = json.decode(res.body);
      if (resdata['error'] != null) {
        throw "${resdata['error']['message']}";
      }
      tokenCustomer = resdata['idToken'];
      myCustomerId = resdata['localId'];
      print("token is :$tokenCustomer");
      print("token is :$myCustomerId");
      CashHelper.putData("tokenCustomer", tokenCustomer);
      CashHelper.putData("cust_id", myCustomerId);
      getCustomerData(myCustomerId);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState());
      throw e;
    }
  }

//////strapi////////////

  Future<void> getCustomer(name, phone, email) async {
    final url = Uri.parse("$base_api/Customers?_where[email]=$email");
    final http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      print(res.body.toString());
      var user = jsonDecode(res.body);
      for (var x in user) {
        id = x['id'];
      }
      editUser(name: name, phone: phone, id: id);
    }
  }
  void editUser({required String name, required String phone, dynamic id}) async {
    final response = await http.put(
        Uri.parse(
          "$base_api/Customers/$id",
        ),
        headers: <String, String>{
          'Context-Type': 'application/json',
        },
        body: <String, String>{
          'username': name,
          'phone': phone,
        });
    if (response.statusCode == 200) {
      print(response.reasonPhrase);
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

  /////////firebase/////////
  Future<void> getCustomerData(myCustomerId) async {
    emit(CustomerLoadinggState());
    await FirebaseFirestore.instance
        .collection("customers")
        .doc(myCustomerId)
        .get()
        .then((value) {
      model = CustomerModel.fromJson(value.data()!);
      emit(CustomerSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CustomerErrorState(error.toString()));
    });
  }

  void changePassword(String email, id) async {
    await FirebaseFirestore.instance.collection('customers').doc(id).get().then((value) {
      if (value.get('email') == email) {
        emit(EmailCustomerisExitState());
        FirebaseAuth.instance
            .sendPasswordResetEmail(email: email)
            .then((value) {
          emit(CustomerPasswordIsChangeState());
        }).catchError((onError) {
          emit(CustomerPasswordIsNotChange());
        });
      } else {
        emit(EmailCustomerisNotExitState());
      }
    }).catchError((onError) {});
  }

  void uploadProfileImage({required String id}) {
    FirebaseStorage.instance
        .ref()
        .child('customers/${Uri.file(imagee!.path).pathSegments.last}')
        .putFile(imagee!)
        .then((value) {
      value.ref.getDownloadURL().then((String? value) {
        print(value);
        updateCustomerImage(image: value, id: id);
        emit(UploadCustomerImageSucessState());

        //profileImageUrl = value!;
      }).catchError((error) {
        emit(UploadCustomerImageErrorState());
      });
    }).catchError((onError) {
      emit(UploadCustomerImageErrorState());
    });
  }

  updateCustomerImage({String? image, required String id}) {
    emit(LoadingChangeCustomerImage());
    FirebaseFirestore.instance
        .collection("customers")
        .doc(id)
        .update({'image': image}).then((value) {
      emit(ChangeCustomerImageSuessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ChangeCustomerImageErrorState());
    });
  }

  updateCustomerData({String? userName, String? phone, required String id}) {
    FirebaseFirestore.instance.collection("customers").doc(id).update({
      'username': userName ?? model!.username,
      'phone': phone ?? model!.phone
    }).then((value) {
      getCustomer(userName, phone, model!.email);
      //  editUser(name: userName!, phone: phone!, email: model!.email);
      emit(UpdateCustomerDataSucessState());
    }).catchError((onError) {
      print(onError.toString());

      emit(UpdateCustomerDataErrorState());
    });
  }

  Future addUserINChat(String userid, String username, String customerid) async {
    emit(CustomerLoadingState());
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(customerid + userid)
        .set({
      "CustomerID": customerid,
      "SenderId": userid,
      "name": username,
      "key": userid + customerid,
      //"image":imguser,
    }).then((value) async {
      final userdata = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerid)
          .get();
      await FirebaseFirestore.instance
          .collection("AllChat")
          .doc(userid + customerid)
          .set({
        "myid": userid,
        "senderid": customerid,
        "name": userdata["username"],
        "key": userid + customerid,
        //  "image":userdata["imgurl"]
      }).then((value) => null);
      emit(CustomerCreateChatState());
    });
  }
}
