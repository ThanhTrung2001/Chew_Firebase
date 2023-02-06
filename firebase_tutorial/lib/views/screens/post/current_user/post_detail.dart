import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/models/comment_model.dart';
import 'package:firebase_tutorial/services/post/post_service.dart';
import 'package:firebase_tutorial/services/token/get_token.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:firebase_tutorial/views/components/search/comment_textfield.dart';
import 'package:firebase_tutorial/views/components/search/search_component.dart';
import 'package:firebase_tutorial/views/screens/photo/photo.dart';
import 'package:firebase_tutorial/views/screens/post/current_user/add_post.dart';
import 'package:firebase_tutorial/views/screens/post/current_user/edit_post.dart';
import 'package:firebase_tutorial/views/screens/post/widgets/comment.dart';
import 'package:firebase_tutorial/views/screens/post/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  String? postID;
  String? postUserName;
  String? avt;
  String? imgLink;
  String? content;
  bool? isFavorite;
  String? uid;
  PostDetailScreen(
      {Key? key,
      required this.postID,
      required this.postUserName,
      required this.avt,
      required this.uid,
      required this.content,
      required this.imgLink,
      required this.isFavorite})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final commentController = TextEditingController();
  final postFunction = PostFunction();
  TokenGenerator tokenGenerator = TokenGenerator();
  UserFunction userFunction = UserFunction();
  late Stream<QuerySnapshot> listComment;
  @override
  void initState() {
    listComment = postFunction.getCommentList(widget.postID, widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'DETAIL',
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
          actions: [
            (FirebaseAuth.instance.currentUser!.uid == widget.uid)
                ? PopupMenuButton(
                    icon: Icon(
                      Icons.info_outline_rounded,
                      size: 30,
                      color: Color(0xFF567BC3),
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text("Edit"),
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text("Delete"),
                        ),
                      ];
                    },
                    onSelected: (value) async {
                      if (value == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPostScreen(
                                    postID: widget.postID!,
                                    content: widget.content!,
                                    imgLink: widget.imgLink!,
                                  )),
                        );
                      } else if (value == 1) {
                        await postFunction.deletePost(widget.postID!);
                        Navigator.of(context).pop();
                      }
                    })
                : SizedBox(),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 21.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColor.blackBorder),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Image.network(widget.avt!, fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      widget.postUserName!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  height: 21.h,
                ),
                Container(
                    width: 289.w,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.content!,
                    )),
                SizedBox(
                  height: 25.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PhotoScreen(url: widget.imgLink!)));
                  },
                  child: Container(
                    height: 166.h,
                    width: 289.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage(widget.imgLink!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 21.h,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 35.w,
                    height: 35.w,
                    child: Image(
                      image: (widget.isFavorite == true)
                          ? AssetImage('assets/icons/favorite.png')
                          : AssetImage('assets/icons/un_favorite.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CommentField(
                    controller: commentController,
                    press: () async {
                      if (commentController.text != "") {
                        final comment = CommentModel(
                            FirebaseAuth.instance.currentUser!.uid,
                            commentController.text,
                            FirebaseAuth.instance.currentUser!.photoURL,
                            DateTime.now());
                        await postFunction.commentOnPost(
                            comment, widget.postID!, widget.uid!);
                        commentController.clear();
                      }
                    }),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0 * size.width / 414),
                  height: (800 - 50 - 75) * size.height / 896,
                  width: double.infinity,
                  child: StreamBuilder(
                      stream: listComment,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            itemCount: snapshot.data?.docs.length as int,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot ds = snapshot.data!.docs[index];
                              String id = ds.id;
                              // String avtComment =
                              // if(ds['hearts'])
                              return Comment(
                                  postUserID: widget.uid!,
                                  uid: ds['uid'],
                                  avtLink: ds['imageLink'],
                                  content: ds['comment'],
                                  onPressedDelete: () async {
                                    await postFunction.deleteComment(
                                        id, widget.postID!, widget.uid!);
                                  });
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
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
      ),
    );
  }
}
