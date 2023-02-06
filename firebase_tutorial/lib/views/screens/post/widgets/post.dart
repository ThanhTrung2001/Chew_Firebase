import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/export.dart';

class Post extends ConsumerStatefulWidget {
  VoidCallback onPressedMenu;
  String avt;
  String uid;
  String postUserName;
  String imgLink;
  String content;
  bool isFavorite;
  VoidCallback onPressedCOmment;
  VoidCallback onPressedPost;
  VoidCallback onPressedAvatar;
  Post({
    Key? key,
    required this.uid,
    required this.avt,
    required this.postUserName,
    required this.imgLink,
    required this.content,
    required this.isFavorite,
    required this.onPressedCOmment,
    required this.onPressedPost,
    required this.onPressedAvatar,
    required this.onPressedMenu,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostState();
}

class _PostState extends ConsumerState<Post> {
  final userService = UserFunction();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 347.w,
      height: 348.h,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                        child: Image.network(widget.avt, fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    widget.postUserName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              (FirebaseAuth.instance.currentUser!.uid == widget.uid)
                  ? Container(
                      width: 25.w,
                      height: 25.w,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Image(
                          image: AssetImage('assets/icons/menu.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          GestureDetector(
            onTap: widget.onPressedPost,
            child: Container(
              height: 166.h,
              width: 289.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image(
                image: NetworkImage(widget.imgLink),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Text(
              widget.content,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 35.w,
                  height: 35.w,
                  child: Image(
                    image: AssetImage('assets/icons/comment.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
