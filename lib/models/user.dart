class User {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final String followers;
  final String following;
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
}
