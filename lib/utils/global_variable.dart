import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/screen/add_post_screen.dart';
import 'package:instagram_clone/screen/feed_screen.dart';
import 'package:instagram_clone/screen/profile_screen.dart';
import 'package:instagram_clone/screen/search_screen.dart';

const webscreensize = 600;

List<Widget> homescreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Center(child: Text("Notification")),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  )
];
