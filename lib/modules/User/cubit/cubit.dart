import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/model/post.dart';

import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/modules/User/home_screen/user_main.dart';
import 'package:helpy_app/modules/User/profile/profile.dart';

import 'package:helpy_app/modules/customer/Chat/chats_screen.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

class UserCubit extends Cubit<cons_login_Register_States> {
  UserCubit() : super(consSignInUp_InitalState());
  static UserCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  late var myid;
  final _auth = FirebaseAuth.instance;
  late UserCredential authres;
  String? mycity, catSelect, specSelect;
  int? cat_id, spec_id;
  int currentindex = 0;

  List screen = [
    const UserHome(),
    ChatsScreen(),
    const UserProfileScreen(),
  ];

  void changeIndex(int index) {
    currentindex = index;
    emit(UserChangeState());
  }

///////////design Login Screen//////////
  bool visable = true;
  void changeDesign() {
    visable = false;
    emit(Cons_Change_Design());
  }

  void changeDesigns() {
    visable = true;
    emit(Cons_Change_Designs());
  }

  IconData iconVisiblity = Icons.visibility;
  bool isPassword = true;
  void changPasswordVisibilty() {
    isPassword = !isPassword;
    iconVisiblity =
        isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibiltyState());
  }
////////////////////////////////////////

  ///dispose controllers
  @override
  Future<void> close() {
    return super.close();
  }

/////////register Method////
  void changeSelectCity(val) {
    mycity = val;
    emit(Cons_ChangeCity_Select());
  }

  void changeSelectCategory(val) {
    catSelect = val.title;
    cat_id = val.id;
    specSelect = null;
    print(catSelect);
    emit(Cons_Change_Cat_Select());
  }

  void changeSelectSpec(val) {
    specSelect = val.specTitle;
    spec_id = val.id;
    print(specSelect);
    emit(Cons_Change_Spec_Select());
  }

  bool type = false;
  String myType = "Company";
  void changeType(val) {
    type = val;
    if (type == false) {
      myType = "Company";
    } else {
      myType = "Freelancer";
    }
    print(myType);
    emit(Cons_Change_type_value());
  }

  final picker = ImagePicker();
  final pickers = ImagePicker();
  var pickedFile, pickedFils;
  File? imagee;

  Future getImageBloc(ImageSource src) async {
    pickedFile = await picker.pickImage(source: src, imageQuality: 50);
    if (pickedFile != null) {
      imagee = File(pickedFile.path);
      emit(TakeImage_State());
      print("image selected");
    } else {
      print("no image selected");
    }
  }

  deleteImageBlocLogin() {
    imagee = null;
    emit(DeleteImage_State());
    print("image Deleted");
  }

  FilePickerResult? result;
  var mediaType;
  void changeMedia(bool media) {
    if (media) {
      mediaType = MediaType('image', 'png');
      print(mediaType);
    } else {
      mediaType = MediaType('application', 'pdf');
      print(mediaType);
    }
  }

  int get myimagecount {
    return result!.files.length;
  }

  deleteImageBlocList() {
    result!.files.clear();
    result = null;
    emit(DeleteImages_State());
    print("images Deleted");
  }

  void pickFiles(mediaXtype, bool allowMultiple) async {
    result = (await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: mediaXtype,
      allowMultiple: allowMultiple,
      withReadStream: true,
      withData: true,
    ))!;
    if (result == null) {
      emit(TakeImagess_Error_State());
    } else {
      emit(TakeImagess_State());
    }
  }

  void uploadImage(Uint8List imageBytes, id) async {
    Map<String, String> a = {
      "files": imagee!.path,
      "ref": "user",
      "refId": "$id",
      "field": "intro_logo",
      "source": "users-permissions"
    };
    String url = base_api + "/upload";
    var stream = http.ByteStream(DelegatingStream.typed(imagee!.openRead()));
    var uri = Uri.parse(url);
    int length = imageBytes.length;
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('files', stream, length,
        filename: basename(imagee!.path),
        contentType: MediaType('image', 'png'));
    request.files.add(multipartFile);
    request.fields.addAll(a);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  void uploadImages(id) {
    result!.files.forEach((element) async {
      String url = base_api + "/upload";
      var uri = Uri.parse(url);
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> a = {
        "files": element.path!,
        "ref": "user",
        "refId": "$id",
        "field": "intro_img",
        "source": "users-permissions"
      };
      var stream = http.ByteStream(DelegatingStream.typed(element.readStream!));
      int? length = element.bytes!.length;
      var multipartFile = http.MultipartFile('files', stream, length,
          filename: basename(element.path!), contentType: mediaType);
      request.fields.addAll(a);
      request.files.add(multipartFile);
      final response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        // ignore: void_checks
      });
    });
  }

  late String error = "Email IsNot Exist";
  bool? forgetpass;
  String? myEmail;
  int? forgetID;
  late String tokenUser;

  register(
      {String? username,
      email,
      password,
      phone,
      String? listImages,
      address,
      about}) async {
    emit(cons_Loading_Register());
    late var response;
    final url = Uri.parse("$base_api/auth/local/register");
    Map<String, String> headrs = {'Accept': 'application/json'};
    Map<String, dynamic> body = {
      'username': username,
      'email': email,
      'password': password,
      "phone": phone,
      "city": mycity,
      "address": address,
      "about": about,
      "type_introducer": myType,
      "Confirmed": false.toString(),
      "intro_img": listImages,
      //"intro_logo":imagee.path,
      "categories": cat_id.toString(),
      "specailst": spec_id.toString(),
    };
    try {
      authres = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection("users")
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
          final loadeddata = jdson['user'];
          myid = loadeddata["id"];
          print(response.body);

          ///upload image logo kant adema h3mlha fe profile
          // uploadImage(imagee.readAsBytesSync(),myid);
          uploadImages(myid);
          emit(cons_Register_Scusess());
          return true;
        } else if (response.statusCode == 400) {
          var jdsonn = jsonDecode(response.body);
          loginModel = LoginModel.fromJson(jdsonn);
          print(loginModel!.message!
              .map((e) => e.messages!.map((e) => e.message.toString())));
          emit(cons_Login_Error(loginModel!));
          return false;
        } else {
          emit(cons_Register_final_Error());
        }
      });
    } on FirebaseException catch (y) {
      emit(cons_Register_firebase_Error());
      throw y;
    } catch (e) {
      emit(cons_Register_finaly_Error());
    }
  }

  login(String email, String password) {
    final url = Uri.parse("$base_api/auth/local");
    Map<String, String> headrs = {
      'Accept': 'application/json',
    };
    Map<String, String> body = {
      'identifier': email,
      'password': password,
    };
    emit(cons_Loading_login());
    getUserLogin(email).then((value) async {
      if (forgetpass == true) {
        emit(cons_getuser_login());
      } else {
        var response = await http.post(url, headers: headrs, body: body);
        if (response.statusCode == 200) {
          var jdson = jsonDecode(response.body);
          loginModel = LoginModel.fromJson(jdson);
          print(body);
          tokenUser = loginModel!.token!;
          int? useriD = loginModel!.userClass!.id;
          CashHelper.putData("userToken", tokenUser);
          CashHelper.putData("userId", useriD);
          emit(cons_Login_Scusess(loginModel!));
          return true;
        } else if (response.statusCode == 400) {
          var jdsonn = jsonDecode(response.body);
          loginModel = LoginModel.fromJson(jdsonn);
          emit(cons_Login_Error(loginModel!));
          // ignore: avoid_print
          print(loginModel!.message!
              .map((e) => e.messages!.map((e) => e.message.toString())));
        }
      }
    });
  }

  ////////////Add Post ////////////////
  PostModel? postModel;
  Future<PostModel?> AddPost(String content, String time, dynamic id) async {
    emit(ConsAddPostUserLoadingState());
    final response = await http.post(
      Uri.parse("$base_api/Posts"),
      headers: <String, String>{
        'Content-Type': 'application/json ',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'content': content,
        'time': time,
        'users_id': id,
      }),
    );
    if (response.statusCode == 200) {
      postModel = PostModel.fromJson(jsonDecode(response.body));
      var jdson = jsonDecode(response.body);
      var id_question = jdson['id'];
      print(" id is $id_question");
      if (imagee == null) {
        print("arf");
      } else {
        uploadPostImage(imagee!.readAsBytesSync(), id_question);
      }
      emit(ConsAddPostUserSucessState());
      return postModel;
    } else if (response.statusCode == 500) {
    } else {
      print(response.body.toString());
      emit(ConsAddPostUserErrorState());
      throw Exception('Failed to Add Post');
    }
  }

  void uploadPostImage(Uint8List imageBytes, id) async {
    Map<String, String> a = {
      "files": imagee!.path,
      "ref": "posts",
      "refId": "$id",
      "field": "img_post",
    };
    String url = base_api + "/upload";
    var stream = http.ByteStream(DelegatingStream.typed(imagee!.openRead()));
    var uri = Uri.parse(url);
    int length = imageBytes.length;
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('files', stream, length,
        filename: basename(pickedFile.path),
        contentType: MediaType('image', 'jpg'));
    request.files.add(multipartFile);
    request.fields.addAll(a);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

////////////////////////strapi/////////////////
  ///Search by Email
  Future<void> getUserLogin(email) async {
    final url = Uri.parse("$base_api/users?_where[email]=$email");
    final http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      print(res.body.toString());
      var user = jsonDecode(res.body);
      for (var x in user) {
        forgetID = x['id'];
        forgetpass = x['forgetpass'];
      }
    } else {
      print('no connect');
    }
  }

  ///Search by ID
  Future<void> getUserDetails(id) async {
    final url = Uri.parse("$base_api/users/$id");
    final http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      print(res.body.toString());
      Map<String, dynamic> user = jsonDecode(res.body);
      loginModel = LoginModel.fromJson(user);
    } else {
      print('no connect');
    }
  }

  Future<void> sendEmail(table, email) async {
    final url = Uri.parse("$base_api/$table?_where[email]=$email");
    final http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      print(res.body.toString());
      var user = jsonDecode(res.body);
      for (var x in user) {
        forgetID = x['id'];
        myEmail = x['email'];
        forgetpass = x['forgetpass'];
      }
      if (myEmail == email) {
        goEmail(table, email, forgetID!);
      } else {
        return myToast(message: error);
      }
    } else {
      print('no connect');
    }
  }

  Future<http.Response> updateForget(
      {required String table, required int id, required bool forget}) {
    return http.put(
      Uri.parse("$base_api/$table/$id"),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, bool>{'forgetpass': forget}),
    );
  }

  Future<http.Response> updatePassStrapi(String newPassword, int? id) {
    return http.put(
      Uri.parse("$base_api/Users/$id"),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'password': newPassword,
      }),
    );
  }

  Future<void> addFile(price, userid, path, name) async {
    emit(UploadUserFileLoadingState());
    Map<String, String> headrs = {
      'Accept': 'application/json',
    };
    Map<String, dynamic> body = {
      "users_permissions_user": userid,
      "price": price,
      "filename": name,
      "Filepdf": path
    };
    final response = await http.post(
      Uri.parse("$base_api/Filesusers"),
      headers: headrs,
      body: body,
    );
    print("done deatils file");
    if (response.statusCode == 200) {
      var jdson = jsonDecode(response.body);
      var id = jdson['id'];
      uploadFilePdf(id);
      emit(UploadUserFileSueeeState());
    } else {
      print("errorrrrrrrrrrrrrr${response.body}");
      emit(UploadUserFileErrorState());
    }
  }

  void uploadFilePdf(id) async {
    result!.files.forEach((element) {
      result!.files.forEach((element) async {
        String url = base_api + "/upload";
        var uri = Uri.parse(url);
        var request = http.MultipartRequest("POST", uri);
        Map<String, String> a = {
          "files": element.path!,
          "ref": "filesuser",
          "refId": "$id",
          "field": "filepdf"
        };
        var stream =
            http.ByteStream(DelegatingStream.typed(element.readStream!));
        int? length = element.bytes!.length;
        var multipartFile = http.MultipartFile('files', stream, length,
            filename: basename(element.path!),
            contentType: MediaType('application', 'pdf'));
        request.fields.addAll(a);
        request.files.add(multipartFile);
        final response = await request.send();
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
          // ignore: void_checks
        });
      });
    });
  }

/////////////////////////firebase////////////////
  Future<void> goEmail(table, email, id) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      updateForget(table: table, id: id, forget: true);
      emit(LoginChangePassSucessState());
    }).catchError((onError) {
      emit(LoginChangePassSucessState());
    });
  }

  bool accepted = false;
  String privacyLabel = 'Privacy Policy';
  void changePrivacy(bool v) {
    accepted = v;
    if (accepted) {
      privacyLabel = 'Privacy Policy (Accepted)';
      emit(AcceptPrivacyState());
    } else {
      privacyLabel = 'Privacy Policy';
      emit(DontAcceptPrivacyState());
    }
  }

  bool isChecked = false;
  void changeChecked(bool v) {
    isChecked = !isChecked;
    isChecked = v;
    emit(ChangeCheckedState());
  }
}
