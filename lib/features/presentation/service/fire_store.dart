import 'package:chat_app/core/app_strings.dart';
import 'package:chat_app/features/presentation/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  addMessage(Message message) {
    firestore.collection(AppStrings.messageCollection).add({
      AppStrings.kMessage: message.message,
      AppStrings.timeCreated: message.createdTime ,
      AppStrings.id : message.id ,
    });
  }

  Stream<QuerySnapshot> loadMessage() {
    return firestore
        .collection(AppStrings.messageCollection)
        .orderBy(AppStrings.timeCreated , descending: true)
        .snapshots();
  }
}
