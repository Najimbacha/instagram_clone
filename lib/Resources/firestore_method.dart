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

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set(
          {
            'profilePic': profilePic,
            'name': name,
            'uid': uid,
            'text': text,
            'commentid': commentId,
            'datePublished': DateTime.now()
          },
        );
      } else {
        print("text Is empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postDelete(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      print(err.toString());
    }
  }
}
