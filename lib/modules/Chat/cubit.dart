import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/Chat/states.dart';

class ConsChat extends Cubit<ConsChatStates> {
  ConsChat() : super(ConInitialState());
  static ConsChat get(context) => BlocProvider.of(context);

   bool isopen=false;

   String? message;
  void changeIcon(String s,randomID){
    if(s.isEmpty){
      typingMessageError(randomID);
      isopen=false;
    }else{
      isopen=true;
      message=s;
      if(s.length>3){
        typingMessageDone(randomID);
      }
    }
    emit(ConsChatChangeIcon());
  }

  Future<void> sendMessage({context,required String custid,required String userid,required String username,})async {
    ConsCubit.get(context).getMyShared();
    try{
      final customerdata= await FirebaseFirestore.instance.collection('AllChat').doc(custid).get();
      final userdata= await FirebaseFirestore.instance.collection('AllChat').doc(userid).get();
      await FirebaseFirestore.instance.collection('AllChat').doc(custid).collection("chats").doc(userid).collection("message").add({
          "text":message,
          "senderid":userid,
          "myid":custid,
          "myname":customerdata["myname"],
          "name":username,
          "image":userdata["senderimage"],
          "date":Timestamp.now(),
          "read":"false"
        });
      await FirebaseFirestore.instance.collection('AllChat').doc(userid).collection("chats").doc(custid).collection("message").add({
        "text":message,
        "senderid":userid,
        "myid":custid,
        "myname":customerdata["myname"],
        "name":username,
        "image":customerdata["myimage"],
        "date":Timestamp.now(),
        "read":"false"
      });
      if(ConsCubit.get(context).customerID==custid){
        print(custid);
        typingMessageError(userid);
      }else{
        print(userid);
        typingMessageError(userid);
      }
    }on FirebaseException catch (y) {
      rethrow;
    }
    emit(ConsChatSucessText());
  }
  Future<void> updateMessageView({required String custid,required String userid})async {
     String? docId;
    final x=await FirebaseFirestore.instance.collection("AllChat").doc(custid).collection("chats").doc(userid).collection("message").get();
    x.docs.forEach((element) {
      docId=element.id;
      print(element.id);
    });
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(custid).collection("chats").doc(userid).collection("message").doc(docId)
        .update({'read': "true"}).then((value) {
      emit(ConsViewedMessage());
    }).catchError((onError) {
      print(onError.toString());
      emit(ConsErrorViewedMessage());
    });
    String? anotherid;
    final w=await FirebaseFirestore.instance.collection("AllChat").doc(userid).collection("chats").doc(custid).collection("message").get();
    w.docs.forEach((element) {
      anotherid=element.id;
      print(element.id);
    });
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(userid).collection("chats").doc(custid).collection("message").doc(anotherid)
        .update({'read': "true"}).then((value) {
      emit(ConsViewedUserMessage());
    }).catchError((onError) {
      print(onError.toString());
      emit(ConsErrorUserViewedMessage());
    });
  }
  Future<void> typingMessageDone(randomID)async{
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(randomID).update({'typing': "true"}).then((value) {
      emit(ConsViewedMessage());
    }).catchError((onError) {
      print(onError.toString());
      emit(ConsErrorViewedMessage());
    });

  }
  Future<void> typingMessageError(randomID)async{
    await FirebaseFirestore.instance
        .collection("AllChat")
        .doc(randomID).update({'typing': "false"}).then((value) {
      emit(ConsViewedMessage());
    }).catchError((onError) {
      print(onError.toString());
      emit(ConsErrorViewedMessage());
    });

  }
  List read=[];
  int get itemCount {
    return read.length;
  }
  bool isread=false;
}