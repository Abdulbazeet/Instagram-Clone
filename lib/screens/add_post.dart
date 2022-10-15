import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/const/colors.dart';
import 'package:instagramclone/models/users.dart';
import 'package:instagramclone/provider/user_provider.dart';
import 'package:instagramclone/resources/firestore_method.dart';
import 'package:instagramclone/resources/utils.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  Uint8List? file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  _createUploadDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List imageFile = await pickImage(ImageSource.camera);
                  setState(() {
                    file = imageFile;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List imageFile = await pickImage(ImageSource.gallery);
                  setState(() {
                    file = imageFile;
                  });
                },
              ),
              SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  void post(String username, String profielImage, String uid) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FirestoreMethod().uploadPosts(
          uid, _descriptionController.text, username, profielImage, file!);
      if (res == "success") {
        setState(() {
          isLoading = false;
          clearImage();
        });
        showSnackBar("Succesful", context);
        clearImage;
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(e.toString(), context);
    }
  }

  void clearImage() {
    setState(() {
      file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Users users = Provider.of<UserProvider>(context).getUser;

    return file == null
        ? Center(
            child: IconButton(
                onPressed: () => _createUploadDialog(context),
                icon: const Icon(Icons.file_upload)),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                "Post to",
                style: TextStyle(fontSize: 20),
              ),
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios), onPressed: clearImage),
              actions: [
                TextButton(
                  onPressed: () =>
                      post(users.username, users.photoUrl, users.uid),
                  child: const Text(
                    "POST",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
            body: isLoading == true
                ? const LinearProgressIndicator()
                : Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(users.photoUrl),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .45,
                            child:  TextField(
                              controller: _descriptionController,
                              decoration: const InputDecoration(
                                  hintText: "Write a caption...",
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: AspectRatio(
                              aspectRatio: 487 / 251,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(file!),
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          );
  }
}
