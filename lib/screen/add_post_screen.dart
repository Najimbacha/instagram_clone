import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Resources/firestore_method.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool _isLoading = false;
  final TextEditingController _descriptioncontroller = TextEditingController();

  postImage(
    String uid,
    String userName,
    String profileImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethod().uploadPost(
          _descriptioncontroller.text, uid, _file!, userName, profileImage);
      if (res == 'done') {
        setState(() {
          _isLoading = false;
        });
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'posted');
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        // ignore: use_build_context_synchronously
        showSnackBar(context, res);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Uint8List? _file;
  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Create a Post"),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.camera,
                );
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.gallery,
                );
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptioncontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    // ignore: unnecessary_null_comparison
    return user == null
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          )
        : _file == null
            ? Center(
                child: IconButton(
                  color: primaryColor,
                  onPressed: () => _selectImage(context),
                  icon: const Icon(
                    Icons.upload,
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: mobileBackgroundColor,
                  leading: IconButton(
                    onPressed: clearImage,
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  title: const Text("Post to "),
                  centerTitle: false,
                  actions: [
                    TextButton(
                      onPressed: () =>
                          postImage(user.uid, user.username, user.photourl),
                      child: const Text(
                        "Post",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                body: Column(
                  children: [
                    _isLoading
                        ? const LinearProgressIndicator(
                            color: Colors.blue,
                          )
                        : const Padding(
                            padding: EdgeInsets.only(
                              top: 0,
                            ),
                          ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(user.photourl),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextField(
                            controller: _descriptioncontroller,
                            decoration: const InputDecoration(
                              hintText: "Write a caption...",
                              border: InputBorder.none,
                            ),
                            maxLines: 8,
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          width: 45,
                          child: AspectRatio(
                            aspectRatio: 487 / 451,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    alignment: FractionalOffset.topCenter,
                                    image: MemoryImage(_file!)),
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    )
                  ],
                ),
              );
  }
}
