import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

import '../../constants/firestore_constants.dart';
import '../../models/user_chat.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(HomeInitial()) {
    on<LoginWithEmailEvent>(_emailLogin);
    on<SignUpEvent>(_emailSignUp);
    on<GoogleEvent>(_googleSignUp);
  }


  Future<void> _emailLogin(LoginWithEmailEvent event, Emitter<AuthState> emit) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      // emit(state.copyWith(firebaseStatus: Status.success));
    } on FirebaseAuthException catch (e) {
      print('error----${e.code}');
      // emit(state.copyWith(firebaseStatus: Status.error));
    }
  }

  Future<void> _emailSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email, password: event.password);

      if (userCredential.user != null) {
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, isEqualTo: userCredential.user?.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.isEmpty) {
          // Writing data to server because here is a new user
          FirebaseFirestore.instance.collection(FirestoreConstants.pathUserCollection).doc(userCredential.user?.uid).set({
            FirestoreConstants.name: userCredential.user?.displayName,
            FirestoreConstants.email: userCredential.user?.email,
            FirestoreConstants.photoUrl: userCredential.user?.photoURL,
            FirestoreConstants.id: userCredential.user?.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            FirestoreConstants.chattingWith: null
          });
        } else {
          // Already sign up, just get data from firestore
          DocumentSnapshot documentSnapshot = documents[0];
          UserChat userChat = UserChat.fromDocument(documentSnapshot);
        }
      }
      // emit(state.copyWith(firebaseStatus: Status.success));
    } on FirebaseAuthException catch (e) {
      print('error----${e.code}');
      // emit(state.copyWith(firebaseStatus: Status.error));
    }
  }

  Future<void> _googleSignUp(GoogleEvent event, Emitter<AuthState> emit) async {
    final googleSign = GoogleSignIn(
      scopes: [
        'email',
        // 'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
      final GoogleSignInAccount? googleUser = await googleSign.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, isEqualTo: userCredential.user?.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.isEmpty) {
          // Writing data to server because here is a new user
          FirebaseFirestore.instance.collection(FirestoreConstants.pathUserCollection).doc(userCredential.user?.uid).set({
            FirestoreConstants.name: userCredential.user?.displayName,
            FirestoreConstants.email: userCredential.user?.email,
            FirestoreConstants.photoUrl: userCredential.user?.photoURL,
            FirestoreConstants.id: userCredential.user?.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            FirestoreConstants.chattingWith: null
          });
        } else {
          // Already sign up, just get data from firestore
          DocumentSnapshot documentSnapshot = documents[0];
          UserChat userChat = UserChat.fromDocument(documentSnapshot);
        }
      }
      print(userCredential.user);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    } catch (e, s) {
      debugPrint('$e, $s');
    }
  }
}
