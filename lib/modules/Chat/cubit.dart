import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/Chat/states.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
// Import package
import 'package:record/record.dart';

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
  late int duration;
  AudioPlayer? audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  int? result;
  int count = 0;
  int maxduration = 20000;
  int currentpos = 0;
  String currentpostlabel = "00:00";
  int? maxDurationInmilliseconds;
  var maxDuration;
  int? seekval;
  var hoursStr = '0';
  var secondsStr = '0';
  var minutesStr = '0';
  StreamController<int>? streamController;
  Timer? timer;
  Duration timerInterval = Duration(milliseconds: 1);
  int counter = 0;
  var timerStream;
  var timerSubscription;

//  var duration1 = Duration(milliseconds: 500);
  void changeIcon(String s, randomID) {
    if (s.isEmpty) {
      typingMessageError(randomID);
      isopen = false;
    } else {
      isopen = true;
      message = s;
      if (s.length > 3) {
        typingMessageDone(randomID);
      }
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
        .get();
    final userdata = await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(userid)
        .get();
    await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(custid)
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
      typingMessageError(userid);
    } else {
      print(userid);
      typingMessageError(userid);
    }

    emit(ConsChatSucessText());
  }

  Future<void> updateMessageView(
      {required String custid, required String userid}) async {
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(custid)
        .collection("chats")
        .doc(userid)
        .collection("message")
        .doc()
        .update({'status': "viewed"}).then((value) {
      emit(ConsViewedMessage());
    }).catchError((onError) {
      print(onError.toString());
      emit(ConsErrorViewedMessage());
    });
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(userid)
        .collection("chats")
        .doc(custid)
        .collection("message")
        .doc()
        .update({'status': "viewed"}).then((value) {
      emit(ConsViewedUserMessage());
    }).catchError((onError) {
      print(onError.toString());
      emit(ConsErrorUserViewedMessage());
    });
  }

  Future<void> typingMessageDone(randomID) async {
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(randomID)
        .update({'typing': "true"}).then((value) {
      emit(ConsViewedMessage());
    }).catchError((onError) {
      print(onError.toString());
      emit(ConsErrorViewedMessage());
    });
  }

  Future<void> typingMessageError(randomID) async {
    await FirebaseFirestore.instance
        .collection("AllChat")
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
        .get();
    final userdata = await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(userid)
        .get();
    await FirebaseFirestore.instance
        .collection('AllChat')
        .doc(custid)
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
      typingMessageError(userid);
    } else {
      print(userid);
      typingMessageError(userid);
    }

    emit(ConsChatSucessText());
  }

  ///////////////Load File/////////////////////////////
  Future loadFile(context) async {
    // final bytes = await readBytes(url);
    tempDir = await getExternalStorageDirectory();
    filePath =
        File('${ConsChat.get(context).tempDir?.path}/audio${count++}.mp3');
    //  await filePath?.writeAsBytes(url);
    if (await filePath!.exists()) {
      print(filePath);
      audioPath = filePath!.path;
      // isPlaying = true;
      await play();
      isPlaying = false;
      emit(ConsChatLoadAudioPlayerChatSucess());
    }
  }

  //////////play audio/////////////////
  Future<void> play() async {
    if (audioPath != null && File(audioPath!).existsSync()) {
      await audioPlayer
          ?.play(audioPath!, isLocal: true, volume: 0.1)
          .then((value) {
        isPlaying = true;
        audioPlayer?.onDurationChanged.listen((Duration duration) {
          print('max duration: ${duration.inSeconds}');
        });

        emit(ChatAudioIsPlaying());
      });
      isPlaying = false;
      audioPlayer?.onDurationChanged.listen((Duration duration) {
        print('max duration: ${duration.inSeconds}');
      });
      duration = await audioPlayer!.getDuration();
      print("Duaration is $duration");
      // isPlaying = false;
    } else {
      isPlaying = false;
    }
  }

////////////////////record Audio/////////////
  void startRecording(context) async {
    if (await record.hasPermission()) {
      print(record.hasPermission().toString());
      //  loadFile(context);
      tempDir = await getExternalStorageDirectory();
      filePath =
          File('${ConsChat.get(context).tempDir?.path}/audio${count++}.mp3');
      //await filePath?.writeAsBytes();
      if (await filePath!.exists()) {
        print(filePath.toString());
        audioPath = filePath!.path;

        print(filePath?.path);

        await record
            .start(
          samplingRate: 44100,
          path: filePath?.path,
          encoder: AudioEncoder.wav, // by default
          bitRate: 128000, // by default
          // by default
        )
            .then((value) {
          isRecording = true;
          emit(RecordingVoiceNoW());
        }).catchError((onError) {
          print("error recording is ${onError.toString()}");
        });
      }
    }
  }

  void StopRecord() async {
    await Record().stop().then((value) {
      isRecording = false;
      emit(StopRecordingNow());
    });
  }

  void labelTimer() {
    audioPlayer?.onAudioPositionChanged.listen((Duration p) {
      currentpos = p.inMilliseconds; //get the current position of playing audio

      //generating the duration label
      int shours = Duration(milliseconds: currentpos).inHours;
      int sminutes = Duration(milliseconds: currentpos).inMinutes;
      int sseconds = Duration(milliseconds: currentpos).inSeconds;

      int rhours = shours;
      int rminutes = sminutes - (shours * 60);
      int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

      currentpostlabel = "$rhours:$rminutes:$rseconds";
    });
  }

  Future<Duration> durationS() async {
    await Future.delayed(const Duration(milliseconds: 2));

    maxDurationInmilliseconds = await audioPlayer!.getDuration();

    maxDuration = Duration(milliseconds: maxDurationInmilliseconds!);
    return maxDuration;
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
    }
  }
}
