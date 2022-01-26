import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/model/customer_model.dart';
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
  register({required String username,required String  email,required String  password,required String  phone}) async{
    emit(RegisterLoadingState());
    late var response;
    final url = Uri.parse("$base_api/Customers");
    Map<String, String> headrs = {
      'Accept': 'application/json'
    };
    Map<String, dynamic> body = {
      'username':username,
      'email': email,
      'password': password,
      "phone":phone,
    };
    try {
      authres=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance.collection("customers").doc(authres.user!.uid).set({'username':username, 'email': email, "phone":phone, "userid":authres.user!.uid,}).then((value) async{
        response= await http.post(url, headers: headrs, body: body);
        if (response.statusCode == 200) {
          var jdson=jsonDecode(response.body);
          myid=jdson["id"];
          print(response.body);
          emit(RegisterSuccessState());
          return true;
        }
        else if(response.statusCode ==400){
         emit(RegisterErrorState());
          return false;
        }
        else{
          emit(RegisterFinalErrorState());
        }
      });
    }on FirebaseException catch (y) {
      emit(RegisterErrorFirebaseState());
      throw y;
    }catch(e){
      emit(RegisterErrorXState());
    }
  }

  late String tokenCustomer;
   String? myCustomerId;


  Future<void> signin(String email, String pass) async {
    emit(LoginLoadingState());
    final url = Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAKbxexl8OzpCBcBj-_Gp5iyM_8mVcumYo");
    try {
      final res = await http.post(url,body:json.encode({
        'email': email,
        'password': pass,
        'returnSecureToken': true,
      }));
      final resdata=json.decode(res.body);
      if(resdata['error'] != null){
        throw "${resdata['error']['message']}";
      }
      tokenCustomer=resdata['idToken'];
      myCustomerId=resdata['localId'];
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



  CustomerModel? model;
  Future<void> getCustomerData(myCustomerId) async{
    emit(CustomerLoadinggState());
    await FirebaseFirestore.instance.collection("customers").doc(myCustomerId).get().then((value){
      model=CustomerModel.fromJson(value.data()!);
      emit(CustomerSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CustomerErrorState(error.toString()));
    });

  }

  int currentindex = 0;
  List<Widget> screen = [
    const CustomerCategory(),
    ChatsScreen(),
    const ProfileScreen(),
  ];

  void changeIndex(int index) {
    currentindex = index;
    emit(CustomerChangeState());
  }

  updateCustomerData({String? userName, String? phone, required String id}) {
    FirebaseFirestore.instance
        .collection("customers")
        .doc(id)
        .update({'username': userName, 'phone': phone}).then((value) {
      emit(UpdateCustomerDataSucessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateCustomerDataErrorState());
    });
  }
  final picker = ImagePicker();
  var pickedFile;
  File? imagee;
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
      // myToast(message: mytranslate(context, "congrate"));
      // updateCustomerStrapi(
      //   username: userName, email: email, phone: phone, id: id);
      emit(ChangeCustomerImageSuessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ChangeCustomerImageErrorState());
    });
  }

  Future<http.Response> updateCustomerStrapi({required String username, required String email, required String phone, dynamic id}) {
    return http.put(
      Uri.parse("$base_api/Customers/$id"),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'phone': phone
      }),
    );
  }

  Future addUserINChat(String userid,String username,String customerid) async {
    emit(CustomerLoadingState());
    await FirebaseFirestore.instance.collection("AllChat").doc(customerid+userid).set({
      "CustomerID": customerid,
      "SenderId": userid,
      "name": username,
      "key":userid+customerid,
      //"image":imguser,
    }).then((value)async{
      final userdata = await FirebaseFirestore.instance.collection('customers').doc(customerid).get();
      await FirebaseFirestore.instance.collection("AllChat").doc(userid+customerid).set(
          {
            "myid": userid,
            "senderid": customerid,
            "name": userdata["username"],
            "key":userid+customerid,
            //  "image":userdata["imgurl"]
          }).then((value) => null);
      emit(CustomerCreateChatState());
    });
  }


  Future<http.Response> updatePassword(String newPassword, int? id) {
    return http.put(
      Uri.parse("$base_api/Customers/$id"),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'password': newPassword,
      }),
    );
  }

  void changePassword(String email, id) async {
    await FirebaseFirestore.instance
        .collection('customers')
        .doc(id)
        .get()
        .then((value) {
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
}