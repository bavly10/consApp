import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/Chat/states.dart';

class ConsChat extends Cubit<ConsChatStates> {
  ConsChat() : super(ConInitialState());
  static ConsChat get(context) => BlocProvider.of(context);

   bool isopen=false;
   String? message;
  void changeIcon(String s){
    if(s.isEmpty){
      isopen=false;
    }else{
      isopen=true;
      message=s;
    }
    emit(ConsChatChangeIcon());
  }

  Future<void> sendMessage({context,required String userid,required String username,})async {
    ConsCubit.get(context).getMyShared();
    final customerid=ConsCubit.get(context).customerID;
    final customerdata= await FirebaseFirestore.instance.collection('AllChat').doc(userid).get();
    final userdata= await FirebaseFirestore.instance.collection('AllChat').doc(userid).get();
    print("userid $userid");
    print("username  $username");
    await FirebaseFirestore.instance.collection('AllChat').doc(customerid).collection("chats").doc(userid).collection("message").add({
      "text":message,
      "senderid":userid,
      "myid":customerid,
      "myname":username,
      "name":customerdata["nameCustomer"],
      "image":userdata["imageIntroduce"],
      "date":Timestamp.now(),
    });
    await FirebaseFirestore.instance.collection('AllChat').doc(userid).collection("chats").doc(customerid).collection("message").add({
      "text":message,
      "senderid":userid,
      "myid":customerid,
      "date":Timestamp.now(),
      "myname":customerdata["nameCustomer"],
      "username":username,
      "image":customerdata["imageCustomer"],
    });
   message==null;
  }
}