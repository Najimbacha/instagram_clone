import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/follow_button.dart';
import 'package:lottie/lottie.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      //get post lenghth
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('Uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLen = postSnap.docs.length;

      userData = userSnap.data()!;
      followers = userSnap.data()!['Follower'].length;
      following = userSnap.data()!['Following'].length;
      isFollowing = userSnap
          .data()!['Follower']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (err) {
      showSnackBar(context, err.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Lottie.asset('assets/load.json', width: 300),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(
                userData['Username'],
              ),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(userData['photourl']),
                            radius: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildstatecolumn(postLen, 'posts'),
                                    buildstatecolumn(followers, 'followers'),
                                    buildstatecolumn(following, 'following'),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FirebaseAuth.instance.currentUser!.uid ==
                                              widget.uid
                                          ? FolllowButton(
                                              backgroundColor:
                                                  mobileBackgroundColor,
                                              borderColor: Colors.grey,
                                              text: 'Edit profile',
                                              function: () {},
                                              textColor: primaryColor,
                                            )
                                          : isFollowing
                                              ? FolllowButton(
                                                  backgroundColor: Colors.white,
                                                  borderColor: Colors.grey,
                                                  text: 'unfollow',
                                                  function: () {},
                                                  textColor: Colors.black,
                                                )
                                              : FolllowButton(
                                                  backgroundColor: Colors.blue,
                                                  borderColor: Colors.blue,
                                                  text: 'Follow',
                                                  function: () {},
                                                  textColor: Colors.white,
                                                )
                                    ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          userData['Username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          userData['Bio'],
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Column buildstatecolumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          label.toString(),
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
      ],
    );
  }
}
