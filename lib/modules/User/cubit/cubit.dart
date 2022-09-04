import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/model/post.dart';

import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/MainScreen/Ads/ads.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/modules/User/home_screen/user_main.dart';
import 'package:helpy_app/modules/User/profile/profile.dart';

import 'package:helpy_app/modules/customer/Chat/chats_screen.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
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
  late String userToken;
  String? numNew;
  String? numOld;

  List screen = [
    const UserHome(),
    ChatsScreen(),
    AdsScreen(),
    UserProfileScreen(),
  ];
  void changePoint(points, id, context) {
    if (points < 1.0) {
      points = points + 0.1;
      print(loginModel?.userClass?.points);
      updatePoints(points, id);
      emit(IncreasePoint());
    } else {
      ConsCubit.get(context).sendAddingNotification(
          name: 'users',
          id: id,
          tittle: "Surely👌",
          body: mytranslate(context, "win"),
          nameSender: "",
          context: context);
      emit(ExceedPoint());
    }
  }

  Future<http.Response> updatePoints(points, id) {
    return http.put(
      Uri.parse("$base_api/users/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'points': points,
      }),
    );
  }

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
  File? image1;
  File? image2;

  Future getImageBloc(ImageSource src, imge) async {
    pickedFile = await picker.pickImage(source: src, imageQuality: 50);
    if (pickedFile != null) {
      if (imge == imagee)
        imagee = File(pickedFile.path);
      else if (imge == image1) image1 = File(pickedFile.path);

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
      mediaType = MediaType('image', 'jpg');
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
    ));
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
        contentType: MediaType('image', 'jpg'));
    request.files.add(multipartFile);
    request.fields.addAll(a);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  void uploadProfileImage(Uint8List imageBytes, id) async {
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
        contentType: MediaType('image', 'jpg'));
    request.files.add(multipartFile);
    request.fields.addAll(a);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  void uploadImagesStrapi(id, String filedName) async {
    result!.files.forEach((element) async {
      String url = base_api + "/upload";
      var uri = Uri.parse(url);
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> a = {
        "files": element.path!,
        "ref": "user",
        "refId": "$id",
        "field": filedName,
        "source": "users-permissions"
      };
      var stream = http.ByteStream(DelegatingStream.typed(element.readStream!));
      int? length = element.bytes!.length;
      var multipartFile = http.MultipartFile('files', stream, length,
          filename: basename(element.path!),
          contentType: MediaType('image', 'jpg'));
      request.fields.addAll(a);
      request.files.add(multipartFile);
      final response = await request.send();
      if (response.statusCode == 200) {
        debugPrint("Sucess");
        emit(ChangeCoverUserImageSuessState());
      } else {
        debugPrint("Faield");
        emit(ChangeCoverUserImageErrorState());
      }
      response.stream.transform(utf8.decoder).listen((value) {
        debugPrint(value);

        // ignore: void_checks
      });
    });
  }

  void uploadProfileUserImage({required String id}) {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imagee!.path).pathSegments.last}')
        .putFile(imagee!)
        .then((value) {
      value.ref.getDownloadURL().then((String? value) {
        print(value);
        updateUserImage(image: value, id: id);
        emit(UploadUserImageSucessState());
      }).catchError((error) {
        print(error);
        emit(UploadUserImageErrorState());
      });
    }).catchError((onError) {
      emit(UploadUserImageErrorState());
    });
  }

  updateUserImage({String? image, required String id}) {
    emit(LoadingChangeUserImageState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({'imageIntroduce': image}).then((value) {
      emit(ChangeUserImageSuessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ChangeUserImageErrorState());
    });
  }

  late String error = "Email IsNot Exist";
  bool? forgetpass;
  String? myEmail;
  int? forgetID;

  register({
    String? username,
    email,
    password,
    phone,
    address,
    about,
  }) async {
    emit(cons_Loading_Register());
    late var response;
    var points = 0.0;
    final url = Uri.parse("$base_api/auth/local/register");
    Map<String, String> headrs = {'Accept': 'application/json'};
    Map<String, dynamic> body = {
      'username': username,
      'email': email,
      'password': password,
      "phone": phone,
      "city": mycity,
      "address": address,
      "introPrice": total.toString(),
      "about": about,
      "type_introducer": myType,
      "Confirmed": false.toString(),
      "categories": cat_id.toString(),
      "specailst": spec_id.toString(),
      "points": points.toString()
    };
    try {
      response = await http.post(url, headers: headrs, body: body);
      print(response.toString());
      if (response.statusCode == 200) {
        var jdson = jsonDecode(response.body);
        final loadeddata = jdson['user'];
        myid = loadeddata["id"];
        print(response.body);
        authres = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(myid.toString())
            .set({
          'username': username,
          'email': email,
          "phone": phone,
          "userid": myid,
        });
        uploadImagesStrapi(myid, "certificate");
        print(myid);
        FirebaseFirestore.instance
            .collection('users')
            .doc(myid.toString())
            .collection('tokens')
            .doc()
            .set({'token': await FirebaseMessaging.instance.getToken()}).then(
                (value) {
          print("login token");
        }).catchError((onError) {
          print('like post error is ${onError.toString()}');
        });
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
        print(response);
        emit(cons_Register_final_Error());
      }
    } on FirebaseException catch (y) {
      emit(cons_Register_firebase_Error());
      throw y;
    } catch (e) {
      print(e.toString());
      emit(cons_Register_finaly_Error());
    }
  }

  Future<void> saveToken(name, id) async {
    FirebaseFirestore.instance
        .collection(name)
        .doc(id.toString())
        .collection('tokens')
        .doc(id.toString())
        .set({'token': await FirebaseMessaging.instance.getToken()}).then(
            (value) {
      FirebaseFirestore.instance
          .collection(name)
          .doc(id.toString())
          .collection('tokens')
          .doc(id.toString())
          .get()
          .then((value) {
        userToken = value.get('token');
        CashHelper.putData("userToken", userToken); //userToken
        print(userToken);
        print("login token");
        emit(GettingUserToken());
      });
    }).catchError((onError) {
      print('Token error is ${onError.toString()}');
    });
  }

  Future<void> login(String email, String password) async {
    emit(cons_Loading_login());
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAKbxexl8OzpCBcBj-_Gp5iyM_8mVcumYo");
    try {
      final res = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final resdata = json.decode(res.body);

      if (resdata['error'] != null) {
        throw "${resdata['error']['message']}";
      }
      var tokenuser = resdata['idToken'];
      CashHelper.putData("userToken", tokenuser);
      getUserLogin(email);

      emit(cons_user_Scusess());
    } catch (e) {
      emit(cons_user_error());
      throw e;
    }
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
    var userid;
    var confirmed;
    final url = Uri.parse("$base_api/users?_where[email]=$email");
    final http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      // print(res.body.toString());
      var resp = jsonDecode(res.body);
      for (var x in resp) {
        userid = x["id"];
        confirmed = x["Confirmed"];
      }
      CashHelper.putData("userId", userid);
      saveToken('users', userid);
      emit(cons_Login_Scusess(confirmed!));
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
      emit(cons_getuser_login());
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
      emit(LoginChangePassSucessState());
    }).catchError((onError) {
      emit(LoginChangePassSucessState());
    });
  }

  String privacyLabel = 'Privacy Policy';
  bool isChecked = false;
  void changeChecked(bool v) {
    isChecked = !isChecked;
    emit(ChangeCheckedState());
    if (isChecked) {
      privacyLabel = 'Privacy Policy (Accepted)';
      emit(AcceptPrivacyState());
    } else {
      privacyLabel = 'Privacy Policy';
      emit(DontAcceptPrivacyState());
    }
  }

  late double total = 0;
  double tax = 0.25;

  double getTotal(int price) {
    double myprice = price * tax;
    total = price + myprice;
    emit(Changeprice());
    return total;
  }
}
