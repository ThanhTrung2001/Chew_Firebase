import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/services/post/post_service.dart';
import 'package:firebase_tutorial/services/token/get_token.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:firebase_tutorial/views/components/search/search_component.dart';
import 'package:firebase_tutorial/views/screens/post/current_user/add_post.dart';
import 'package:firebase_tutorial/views/screens/post/current_user/post_detail.dart';
import 'package:firebase_tutorial/views/screens/post/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactPostScreen extends ConsumerStatefulWidget {
  String uid;
  String contactName;
  ContactPostScreen({Key? key, required this.uid, required this.contactName})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ContactPostScreenState();
}

class _ContactPostScreenState extends ConsumerState<ContactPostScreen> {
  final searchController = TextEditingController();
  late Stream<QuerySnapshot> listPost;
  final postFunction = PostFunction();
  void search() {
    if (searchController.text == "") {
      setState(() {
        // userStream = userFunction.getUserList();
      });
    } else {
      setState(() {
        // userStream = userFunction.searchuserByName(searchController.text);
      });
    }
  }

  @override
  void initState() {
    listPost = postFunction.getPostList(widget.uid);
    super.initState();
  }

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
            'CONTACT POST',
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
              Divider(
                indent: 157.w,
                endIndent: 157.w,
                color: AppColor.blackBorder,
                thickness: 3,
              ),
              SizedBox(
                height: 21.h,
              ),
              // Container(
              //   alignment: Alignment.center,
              //   padding: EdgeInsets.symmetric(horizontal: 33.w),
              //   width: 400,
              //   height: 600.h,
              //   child: ListView.builder(
              //       itemCount: 1,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Post(
              //           onPressedMenu: () {},
              //           onPressedPost: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => PostDetailScreen()),
              //             );
              //           },
              //         );
              //       }),
              // )
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0 * size.width / 414),
                height: (800 - 50 - 75) * size.height / 896,
                width: double.infinity,
                child: StreamBuilder(
                    stream: listPost,
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          itemCount: snapshot.data?.docs.length as int,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot ds = snapshot.data!.docs[index];
                            String id = ds.id;
                            // if(ds['hearts'])
                            return Post(
                              uid: ds['uid'],
                              postUserName: widget.contactName,
                              avt: ds['avt'],
                              imgLink: ds['imgLinks'][0],
                              content: ds['content'],
                              isFavorite: false,
                              onPressedAvatar: () {},
                              onPressedCOmment: () {},
                              onPressedPost: () {
                                print(id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostDetailScreen(
                                            postUserName: widget.contactName,
                                            postID: id,
                                            avt: ds['avt'],
                                            uid: ds['uid'],
                                            content: ds['content'],
                                            imgLink: ds['imgLinks'][0],
                                            isFavorite: false,
                                          )),
                                );
                              },
                              onPressedMenu: () {},
                              // ds['isImage'], ds['senderUID'], ds['content']
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error');
                      } else {
                        return Text('Loading');
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
