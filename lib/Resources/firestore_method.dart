import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/Resources/storage_method.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String desciption,
    String uid,
    Uint8List file,
    String userName,
    String profileImage,
  ) async {
    String res = "some error occured";
    try {
      String photourl =
          await StorageMethod().uploadimagetostorage("posts", file, true);

      String postId = const Uuid().v1();

      Post post = Post(
        description: desciption,
        uid: uid,
        userName: userName,
        postId: postId,
        publishDate: DateTime.now(),
        postUrl: photourl,
        profileImage: profileImage,
        likes: [],
      );
      res = 'done';

      _firestore.collection('posts').doc(postId).set(post.toJson());
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
