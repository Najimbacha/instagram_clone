import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.only(left: 40, top: 40),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.bio),
              ),
              const SizedBox(width: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  user.photourl,
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  user.photourl,
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  user.photourl,
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  user.photourl,
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  user.photourl,
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  user.photourl,
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  user.photourl,
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  user.photourl,
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  user.photourl,
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  user.photourl,
                ),
              ),
            ],
          )),
    );
  }
}
