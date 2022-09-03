import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
//import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/model/audio_model.dart';
import 'package:helpy_app/modules/Chat/states.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
// Import package
import 'package:record/record.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'dart:io' as io;

class ConsChat extends Cubit<ConsChatStates> {
  ConsChat() : super(ConInitialState());
  static ConsChat get(context) => BlocProvider.of(context);

  bool isopen = false;
  String? message;
  Directory? tempDir;
  File? filePath;
  String? audioPath;
  bool isRecording = false;
  bool isPlaying = false;
  final record = Record();
  int duration = 2000;
  Directory? downloadsDirectory;
  bool isClose = false;
  // String? token;

  final player = AudioPlayer();

  int count = 0;

  int currentpos = 0;

  var maxDuration;

  var hoursStr = '0';
  var secondsStr = '0';
  var minutesStr = '0';
  StreamController<int>? streamController;
  Timer? timer;
  Duration timerInterval = Duration(milliseconds: 1);
  int counter = 0;
  var timerStream;
  var timerSubscription;
  int? shours, sminutes, sseconds, rhours, rminutes, rseconds;

//////////////////////////////////////////////
  void changeIcon(String s, randomID, context) {
    if (s.isEmpty) {
      typingMessageError(randomID, context);
      isopen = false;
    } else {
      isopen = true;
      message = s;

      // if (s.length > 3) {
      //   typingMessageDone(randomID, context);
      // }
    }
    emit(ConsChatChangeIcon());
  }

  Future<void> sendMessage({
    context,
    required String custid,
    required String userid,
    required String username,
  }) async {
    ConsCubit.get(context).getMyShared();
    final customerdata = await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(custid)
        .collection('contact')
        .doc(userid)
        .get();
    final userdata = await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(userid)
        .collection('contact')
        .doc(custid)
        .get();
    await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(custid)
        .collection('contact')
        .doc(userid)
        .collection("chats")
        .doc(userid)
        .collection("message")
        .add({
      "text": message,
      "senderid": userid,
      "myid": custid,
      "myname": customerdata["myname"],
      "name": username,
      "image": userdata["senderimage"],
      "date": Timestamp.now(),
      "status": "Arrived",
      "type": "text"
    });
    await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(userid)
        .collection('contact')
        .doc(custid)
        .collection("chats")
        .doc(custid)
        .collection("message")
        .add({
      "text": message,
      "senderid": userid,
      "myid": custid,
      "myname": customerdata["myname"],
      "name": username,
      "image": customerdata["myimage"],
      "date": Timestamp.now(),
      "status": "Arrived",
      "type": "text"
    }).catchError((onError) {});
    if (ConsCubit.get(context).customerID == custid) {
      print(custid);
      typingMessageError(userid, context);
    } else {
      print(userid);
      typingMessageError(userid, context);
    }

    emit(ConsChatSucessText());
  }

  Future<void> updateMessageView(
      {required String custid, required String userid, context}) async {
    await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(custid)
        .collection('contact')
        .doc(userid)
        .collection("chats")
        .doc(userid)
        .collection("message")
        .doc()
        .set({'status': "viewed"}).then((value) {
      emit(ConsViewedMessage());
    }).catchError((onError) {
      print(onError.toString());
      emit(ConsErrorViewedMessage());
    });
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(userid)
        .collection('contact')
        .doc(custid)
        .collection("chats")
        .doc(custid)
        .collection("message")
        .doc()
        .set({'status': "viewed"}).then((value) {
      emit(ConsViewedUserMessage());
    }).catchError((onError) {
      print(onError.toString());
      emit(ConsErrorUserViewedMessage());
    });
  }

  Future<void> typingMessageDone(randomID, context) async {
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(ConsCubit.get(context).localID)
        .collection('contact')
        .doc(randomID)
        .update({'typing': "true"}).then((value) {
      emit(ConsViewedMessage());
    }).catchError((onError) {
      print(onError.toString());
      emit(ConsErrorViewedMessage());
    });
  }

  Future<void> typingMessageError(randomID, context) async {
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(ConsCubit.get(context).localID)
        .collection('contact')
        .doc(randomID)
        .update({'typing': "false"}).then((value) {
      emit(ConsViewedMessage());
    }).catchError((onError) {
      print(onError.toString());
      emit(ConsErrorViewedMessage());
    });
  }

  /////////////upload Audio File/////////////
  uploadAudio({
    context,
    required String custid,
    required String userid,
    required String username,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('AudioChat/${Uri.file(audioPath!).pathSegments.last}')
        .putFile(File(audioPath!))
        .then((value) {
      value.ref.getDownloadURL().then((String? value) {
        print(value);
        sendAudio(
            context: context,
            custid: custid,
            userid: userid,
            username: username,
            audio: value!);
        emit(ConsChatUploadAudioChatSucess());

        //profileImageUrl = value!;
      }).catchError((error) {
        emit(ConsChatUploadAudioChatError());
      });
    }).catchError((onError) {
      emit(ConsChatUploadAudioChatError());
    });
  }

  //////////////////////Send Audio File/////////////////////////
  ///
  Future<void> sendAudio({
    context,
    required String custid,
    required String userid,
    required String username,
    required String audio,
  }) async {
    ConsCubit.get(context).getMyShared();
    final customerdata = await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(custid)
        .collection('contact')
        .doc(userid)
        .get();

    final userdata = await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(userid)
        .collection('contact')
        .doc(custid)
        .get();
    AudioModel audioModel = AudioModel(
        date: Timestamp.now(),
        mesage: audio,
        useriamg: userdata["senderimage"],
        username: username,
        viewed: true,
        myId: custid,
        myname: customerdata["myname"],
        senderId: userdata["senderimage"],
        type: 'audio');
    await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(custid)
        .collection('contact')
        .doc(userid)
        .collection("chats")
        .doc(userid)
        .collection("message")
        .add({
      "vurl": audio,
      "senderid": userid,
      "myid": custid,
      "myname": customerdata["myname"],
      "name": username,
      "image": userdata["senderimage"],
      "date": Timestamp.now(),
      "status": "Arrived",
      "type": "audio"
    });
    await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(userid)
        .collection('contact')
        .doc(custid)
        .collection("chats")
        .doc(custid)
        .collection("message")
        .add({
      "vurl": audio,
      "senderid": userid,
      "myid": custid,
      "myname": customerdata["myname"],
      "name": username,
      "image": customerdata["myimage"],
      "date": Timestamp.now(),
      "status": "Arrived",
      "type": "audio"
    }).catchError((onError) {});
    if (ConsCubit.get(context).customerID == custid) {
      print(custid);
      typingMessageError(userid, context);
    } else {
      print(userid);
      typingMessageError(userid, context);
    }

    emit(ConsChatSucessText());
  }

  ///////////////Load File/////////////////////////////
  Future loadFile(context, String url, index) async {
    emit(WaithingToOPenAudio());

    print("url is...$url");
    final bytes = await readBytes(Uri.parse(url));
    tempDir = await getExternalStorageDirectory();
    filePath = File('${tempDir?.path}/audio${count++}.mp3');
    await filePath?.writeAsBytes(bytes);
    if (await filePath!.exists()) {
      print(filePath);
      audioPath = filePath!.path;

      await play(audioPath, index);

      emit(ConsChatLoadAudioPlayerChatSucess());
    } else {
      print('There is some errors here....');
    }
  }

  //////////play audio/////////////////
  Future<void> play(url, index) async {
    print("playyy this audio${url.toString()}");

    maxDuration = await player.setUrl(url);

    player.play().asStream().listen((event) {
      stopPlay(url);
      audioSelectedList[index] = false;
    });

    emit(ChatAudioIsPlaying());
  }

////////////////////record Audio/////////////
  void startRecording(context) async {
    if (await record.hasPermission()) {
      print(record.hasPermission().toString());

      tempDir = await getExternalStorageDirectory();
      filePath = File('${tempDir?.path}/audio${count++}.mp3');

      print(filePath.toString());
      audioPath = filePath!.path;

      print(filePath?.path);

      await record
          .start(
        samplingRate: 44100,
        path: filePath?.path,
        encoder: AudioEncoder.aacLc, // by default
        bitRate: 128000, // by default
        // by default
      )
          .then((value) {
        isRecording = true;
        emit(RecordingVoiceNoW());
      }).catchError((onError) {
        print("error recording is ${onError.toString()}");
      });

      // }
    }
    final picker = ImagePicker();
    final pickers = ImagePicker();
    var pickedFile, pickedFils;
    File? imagee;

    Future getImageBloc(ImageSource src) async {
      pickedFile = await picker.pickImage(source: src, imageQuality: 50);
      if (pickedFile != null) {
        imagee = File(pickedFile.path);
        //emit(TakeImage_State());
        print("image selected");
      } else {
        print("no image selected");
      }
    }
  }

  //////////////////stop record///////////////////////
  void StopRecord() async {
    await Record().stop().then((value) {
      isRecording = false;
      emit(StopRecordingNow());
    });
  }

  void labelTimer(index) {
    player.positionStream.listen((Duration p) {
      currentpos = p.inMilliseconds; //get the current position of playing audio

      //generating the duration label
      shours = Duration(milliseconds: currentpos).inHours;
      sminutes = Duration(milliseconds: currentpos).inMinutes;
      sseconds = Duration(milliseconds: currentpos).inSeconds;

      rhours = shours;
      rminutes = sminutes! - (shours! * 60);
      rseconds = sseconds! - (sminutes! * 60 + shours! * 60 * 60);

      currentpostlabel = "$rhours:$rminutes:$rseconds";
      currentpostlabell[index] = currentpostlabel;

      emit(ChangeCurrentPostLabel());
    });
  }

  Stream<int> stopWatchStream() {
    void stopTimer() {
      if (timer != null) {
        timer?.cancel();
        timer = null;
        counter = 0;
        streamController?.close();
      }
    }

    void tick(_) {
      counter++;
      streamController?.add(counter);
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );
    emit(StartingTimerOfRecord());
    return streamController!.stream;
  }

  void changeTime(newTick) {
    hoursStr = ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
    secondsStr = (newTick % 60).floor().toString().padLeft(2, '0');
  }

  void changeStopTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
      counter = 0;
      streamController!.close();
      emit(StopTimerOfRecord());
    }
  }

  Future<void> stopPlay(url) async {
    isPlaying = false;
    await player.setUrl(url);
    await player.stop().then((value) {
      emit(ChatAudioIsPause());
    });
  }

  Future<void> pausePlay(url) async {
    isPlaying = false;
    await player.setUrl(url);
    await player.pause().then((value) {
      emit(ChatAudioIsPause());
    });
  }

  String currentpostlabel = "00.00";
  List<DocumentSnapshot?>? doc;
  late List<String> currentpostlabell =
  List.generate(audioSelectedList.length, (index) => "00.00");

  late List<bool> audioSelectedList =
  List.generate(doc!.length + 3, (index) => false);
  void selected(index, length, document, context, url) {
    audioSelectedList = List.generate(document.length, (i) => false);
    audioSelectedList[index] = true;
    loadFile(context, url, index);
    if (audioSelectedList[index] == true) {
      isPlaying = true;
    }

    emit(ChangePlaying());
  }

  var stopWatchTimer = StopWatchTimer();
  onWatchChange(value) {
    stopWatchTimer = StopWatchTimer(
      isLapHours: true,
      mode: StopWatchMode.countUp,
      onChange: (value) => print('onChange $value'),
      onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
      onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    );
    emit(ChangeTime());
  }

///////////////////////////////Pdf File////////////////////
  var pickedFile;

  FilePickerResult? result;
  void pickFiles(mediaXtype, bool allowMultiple) async {
    result = (await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: mediaXtype,
      allowMultiple: allowMultiple,
      withReadStream: true,
      withData: true,
    ));
    if (result == null) {
      emit(PickChatFileError());
    } else {
      emit(PickChatFileSucess());
    }
  }

  Future<void> sendPdfFile(
      {context,
        required String custid,
        required String userid,
        required String username,
        required String file,
        required String fileName,
        required int sizefile}) async {
    ConsCubit.get(context).getMyShared();
    final customerdata = await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(custid)
        .collection('contact')
        .doc(userid)
        .get();

    final userdata = await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(userid)
        .collection('contact')
        .doc(custid)
        .get();

    await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(custid)
        .collection('contact')
        .doc(userid)
        .collection("chats")
        .doc(userid)
        .collection("message")
        .add({
      "furl": file,
      "filename": fileName,
      "sizefile": sizefile,
      "senderid": userid,
      "myid": custid,
      "myname": customerdata["myname"],
      "name": username,
      "image": userdata["senderimage"],
      "date": Timestamp.now(),
      "status": "Arrived",
      "type": "pdf"
    });
    await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(userid)
        .collection('contact')
        .doc(custid)
        .collection("chats")
        .doc(custid)
        .collection("message")
        .add({
      "furl": file,
      "filename": fileName,
      "sizefile": sizefile,
      "senderid": userid,
      "myid": custid,
      "myname": customerdata["myname"],
      "name": username,
      "image": customerdata["myimage"],
      "date": Timestamp.now(),
      "status": "Arrived",
      "type": "pdf"
    }).catchError((onError) {});
    if (ConsCubit.get(context).customerID == custid) {
      print(custid);
      typingMessageError(userid, context);
    } else {
      print(userid);
      typingMessageError(userid, context);
    }

    emit(ConsChatSucessText());
  }

  uploadFilePdf({
    context,
    required String custid,
    required String userid,
    required String username,
  }) {
    if (result!.files.single.size <= 5242880) {
      FirebaseStorage.instance
          .ref()
          .child(
          'PdfChat/${Uri.file(result!.files.single.path!).pathSegments.last}')
          .putFile(File(result!.files.single.path!))
          .then((value) {
        value.ref.getDownloadURL().then((String? value) {
          print(value);
          sendPdfFile(
              context: context,
              custid: custid,
              userid: userid,
              username: username,
              file: value!,
              fileName: result!.files.single.name,
              sizefile: result!.files.single.size);
          emit(ConsChatUploadFilePdfChatSucess());

          //profileImageUrl = value!;
        }).catchError((error) {
          emit(ConsChatUploadFilePdfChatError());
        });
      }).catchError((onError) {
        emit(ConsChatUploadFilePdfChatError());
      });
    } else {
      print(result!.files.single.size);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: myAmber,
        content: Text(mytranslate(context, "exceed")),
      ));
    }
  }

  Future<void> downloadFille(String url, context, fileName) async {
    var dio = Dio();
    var dir = await getExternalStorageDirectory();
    var downloadDir = await io.Directory(dir!.path).create(recursive: true);
    io.File('${downloadDir.path}/$fileName').exists().then((a) async {
      print("Downloading file");
      print(downloadDir.path);
      await dio
          .download(url, '${downloadDir.path}/$fileName.pdf')
          .then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: myAmber,
          content: Text(mytranslate(context, "path") + "$fileName"),
        )),
        print("Download completed"),
        emit(DownloadFileChat()),
      });
    });
  }

  ///////////////////////////////////Upload&send image///////////////////////
  final picker = ImagePicker();

  File? imagee;
  Future getImageBloc(ImageSource src) async {
    pickedFile = await picker.pickImage(source: src, imageQuality: 50);
    if (pickedFile != null) {
      imagee = File(pickedFile.path);
      emit(TakeImageState());
      print("image selected");
    } else {
      print("no image selected");
    }
  }

  void uploadImageChat(
      {context,
        required String custid,
        required String userid,
        required String username}) {
    FirebaseStorage.instance
        .ref()
        .child('ImageChat/${Uri.file(imagee!.path).pathSegments.last}')
        .putFile(imagee!)
        .then((value) {
      value.ref.getDownloadURL().then((String? value) {
        print(value);
        sendImageChat(
            context: context,
            custid: custid,
            userid: userid,
            username: username,
            imagechat: value!);
        emit(UploadImageChatSucessState());

        //profileImageUrl = value!;
      }).catchError((error) {
        emit(UploadImageChatErrorState());
      });
    }).catchError((onError) {
      emit(UploadImageChatErrorState());
    });
  }

  Future<void> sendImageChat({
    context,
    required String custid,
    required String userid,
    required String username,
    required String imagechat,
  }) async {
    ConsCubit.get(context).getMyShared();
    final customerdata = await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(custid)
        .collection('contact')
        .doc(userid)
        .get();

    final userdata = await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(userid)
        .collection('contact')
        .doc(custid)
        .get();

    await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(custid)
        .collection('contact')
        .doc(userid)
        .collection("chats")
        .doc(userid)
        .collection("message")
        .add({
      "imagechat": imagechat,
      "senderid": userid,
      "myid": custid,
      "myname": customerdata["myname"],
      "name": username,
      "image": userdata["senderimage"],
      "date": Timestamp.now(),
      "status": "Arrived",
      "type": "image"
    });
    await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(userid)
        .collection('contact')
        .doc(custid)
        .collection("chats")
        .doc(custid)
        .collection("message")
        .add({
      "imagechat": imagechat,
      "senderid": userid,
      "myid": custid,
      "myname": customerdata["myname"],
      "name": username,
      "image": customerdata["myimage"],
      "date": Timestamp.now(),
      "status": "Arrived",
      "type": "image"
    }).catchError((onError) {});
    if (ConsCubit.get(context).customerID == custid) {
      print(custid);
      typingMessageError(userid, context);
    } else {
      print(userid);
      typingMessageError(userid, context);
    }

    emit(ConsChatSucessText());
  }
}