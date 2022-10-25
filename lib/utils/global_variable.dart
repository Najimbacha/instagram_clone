import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/screen/add_post_screen.dart';
import 'package:instagram_clone/screen/feed_screen.dart';
import 'package:instagram_clone/screen/profile_screen_demo.dart';

const webscreensize = 600;

const homescreenItems = [
  FeedScreen(),
  Center(child: Text("Search")),
  AddPostScreen(),
  Center(child: Text("Notification")),
  ProfileScreen(),
];
