import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String userName;
  final String postId;
  // ignore: prefer_typing_uninitialized_variables
  final publishDate;
  final String postUrl;
  final String profileImage;
  // ignore: prefer_typing_uninitialized_variables
  final likes;

  const Post(
      {required this.description,
      required this.uid,
      required this.userName,
      required this.postId,
      required this.publishDate,
      required this.postUrl,
      required this.profileImage,
      required this.likes});

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "postId": postId,
        "publishDate": publishDate,
        "postUrl": postUrl,
        "username": userName,
        "profileImage": profileImage,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot['description'],
      uid: snapshot['uid'],
      userName: snapshot['username'],
      postId: snapshot['postId'],
      publishDate: snapshot['publishDate'],
      postUrl: snapshot['postUrl'],
      profileImage: snapshot['profileImage'],
      likes: snapshot['likes'],
    );
  }
}
