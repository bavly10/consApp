import 'package:cloud_firestore/cloud_firestore.dart';

class AudioModel {
  String? username, mesage, useriamg, myname;
  String? myId, senderId, type;
  late Timestamp date;
  bool? viewed;
  AudioModel(
      {required this.date,
      this.mesage,
      this.useriamg,
      this.username,
      this.viewed,
      this.myId,
      this.senderId,
      this.type,
      this.myname});
  factory AudioModel.fromDocument(QueryDocumentSnapshot documentSnapshot) {
    String username = documentSnapshot.get('myName');
    String mesage = documentSnapshot.get('vurl');
    String useriamg = documentSnapshot.get('image');
    Timestamp date = documentSnapshot.get('date');
    bool viewed = documentSnapshot.get('status');
    String myId = documentSnapshot.get('myid');
    String senderId = documentSnapshot.get('senderid');
    String type = documentSnapshot.get('type');
    String myName = documentSnapshot.get('myname');

    return AudioModel(
        date: date,
        mesage: mesage,
        useriamg: useriamg,
        username: username,
        viewed: viewed,
        myId: myId,
        myname: myName,
        senderId: senderId,
        type: type);
  }

  AudioModel.fromJson(Map<dynamic, dynamic> json) {
    username = json['myname'];
    mesage = json['vurl'];
    useriamg = json['image'];
    date = json['date'];
    viewed = json['status'];
  }
  Map<String, dynamic> toMap() {
    return {
      'myname': username,
      'vurl': mesage,
      'image': useriamg,
      'data': date,
      'status': viewed
    };
  }
}
