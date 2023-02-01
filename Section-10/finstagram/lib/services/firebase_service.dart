import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  late Map? currentUser;

  static const String USERS_COLLECTION = "users";
  static const String POSTS_COLLECTION = "posts";

  FirebaseService();

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask task = _storage.ref('images/$userId/$fileName').putFile(image);
      return task.then((snapshot) async {
        String downloadURL = await snapshot.ref.getDownloadURL();
        await _db.collection(USERS_COLLECTION).doc(userId).set({
          "name": name,
          "email": email,
          "image": downloadURL,
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        currentUser = await getUserData(userCredential.user!.uid);
      }

      return (userCredential.user != null);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> getUserData(String uid) async {
    DocumentSnapshot doc =
        await _db.collection(USERS_COLLECTION).doc(uid).get();
    return doc.data() as Map;
  }

  Future<bool> postImage(File image) async {
    try {
      String userId = _auth.currentUser!.uid;
      String fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask task = _storage.ref('images/$userId/$fileName').putFile(image);
      return task.then((snapshot) async {
        String downloadURL = await snapshot.ref.getDownloadURL();
        await _db.collection(POSTS_COLLECTION).add({
          "userId": userId,
          "timestamp": Timestamp.now(),
          "image": downloadURL,
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getLatestPosts() {
    return _db
        .collection(POSTS_COLLECTION)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getPostsForUser() {
    String userId = _auth.currentUser!.uid;
    return _db
        .collection(POSTS_COLLECTION)
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
