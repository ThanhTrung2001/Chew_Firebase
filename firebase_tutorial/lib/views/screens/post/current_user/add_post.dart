import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/models/post_model.dart';
import 'package:firebase_tutorial/services/images/image_service.dart';
import 'package:firebase_tutorial/services/post/post_service.dart';
import 'package:firebase_tutorial/services/token/get_token.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:firebase_tutorial/views/components/buttons/button_mini_login.dart';
import 'package:firebase_tutorial/views/components/search/search_component.dart';
import 'package:firebase_tutorial/views/components/textfields/textfield_long.dart';
import 'package:firebase_tutorial/views/screens/post/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  final contentController = TextEditingController();
  final imageFunction = ImageFunction();
  final postFunction = PostFunction();
  String imgLink = "";
  @override
  Widget build(BuildContext context) {
    TokenGenerator tokenGenerator = TokenGenerator();
    UserFunction userFunction = UserFunction();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'ADD',
            style: AppTextStyle.appbarTitle,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(top: 17.h, left: 10.w),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: AppIcon.back),
          ),
          actions: [],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ContentTextField(
                  controller: contentController, hint: "Type content here"),
              SizedBox(
                height: 25.h,
              ),
              GestureDetector(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg'],
                  );
                  if (result != null) {
                    final path = result.files.single.path!;
                    final name = result.files.single.name;
                    await imageFunction.uploadPostImage(
                        path, FirebaseAuth.instance.currentUser!.uid, name);
                    final url = await imageFunction.downloadPostURL(
                        FirebaseAuth.instance.currentUser!.uid, name);
                    print(path + '----' + name);
                    if (url != null) {
                      setState(() {
                        imgLink = url;
                      });
                    } else {
                      print("error");
                    }
                  }
                },
                child: Container(
                  height: 323.h,
                  width: 310.w,
                  child: (imgLink == "")
                      ? Image.asset(
                          "assets/icons/add_image.png",
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          imgLink,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              LoginMiniButton(
                  title: "Post",
                  color: Color.fromARGB(255, 3, 103, 185),
                  onPressed: () async {
                    final post = PostModel(
                        FirebaseAuth.instance.currentUser!.uid,
                        FirebaseAuth.instance.currentUser!.photoURL,
                        contentController.text,
                        [imgLink],
                        [],
                        DateTime.now(),
                        false);
                    await postFunction.createPost(post);
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
