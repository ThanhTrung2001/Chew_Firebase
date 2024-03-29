import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/models/user_model.dart';
import 'package:firebase_tutorial/services/auth/authenticate_service.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:firebase_tutorial/views/components/buttons/button_mini_login.dart';
import 'package:firebase_tutorial/views/screens/post/contact_user/contact_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ContactProfileScreen extends ConsumerStatefulWidget {
  String uid;
  ContactProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ContactProfileScreenState();
}

class _ContactProfileScreenState extends ConsumerState<ContactProfileScreen> {
  UserFunction userFunction = UserFunction();
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Contacter',
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
            GestureDetector(
              onTap: () {},
              child: AppIcon.userSetting,
            ),
          ],
        ),
        body: Center(
          child: StreamBuilder(
            stream:
                users.doc(widget.uid).snapshots(includeMetadataChanges: true),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 89.h,
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      width: 150.h,
                      height: 150.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColor.blackBorder),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Image.network('${snapshot.data['avtLink']}',
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    Text(
                      '${snapshot.data['name']}',
                    ),
                    SizedBox(
                      height: 31.h,
                    ),
                    LoginMiniButton(
                        title: "Post",
                        color: const Color(0xFF285BA7),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContactPostScreen(
                                      contactName: snapshot.data['name'],
                                      uid: snapshot.data['uid'],
                                    )),
                          );
                        }),
                    SizedBox(
                      height: 19.h,
                    ),
                    Text(
                      'Description',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 174.h,
                      width: 314.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColor.blueButton,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('description'),
                        ],
                      ),
                    ),
                    //  SizedBox(
                    //   height: 20.h,
                    // ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error');
              } else {
                return Text('loading');
              }
            },
          ),
        ),
      ),
    );
  }
}
