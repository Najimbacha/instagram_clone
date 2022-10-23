import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final List followers;
  final List following;
  final String photourl;

  const User({
    required this.username,
    required this.uid,
    required this.bio,
    required this.email,
    required this.followers,
    required this.following,
    required this.photourl,
  });

  Map<String, dynamic> toJson() => {
        "Username": username,
        "Uid": uid,
        "Email": email,
        "Bio": bio,
        "Follower": followers,
        "Following": following,
        "photourl": photourl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        username: snapshot['Username'],
        uid: snapshot['Uid'],
        bio: snapshot['Bio'],
        email: snapshot['Email'],
        followers: snapshot['Follower'],
        following: snapshot['Following'],
        photourl: snapshot['photourl']);
  }
}
