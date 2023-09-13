
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_constants.dart';

class UserChat {
  final String id;
  final String photoUrl;
  final String name;
  final String email;

  const UserChat({required this.id, required this.photoUrl, required this.name, required this.email});

  Map<String, String> toJson() {
    return {
      FirestoreConstants.name: name,
      FirestoreConstants.email: email,
      FirestoreConstants.photoUrl: photoUrl,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String email = "";
    String photoUrl = "";
    String nickname = "";
    try {
      email = doc.get(FirestoreConstants.email);
    } catch (e) {}
    try {
      photoUrl = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    try {
      nickname = doc.get(FirestoreConstants.name);
    } catch (e) {}
    return UserChat(
      id: doc.id,
      photoUrl: photoUrl,
      name: nickname,
      email: email,
    );
  }
}