import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/models/user_model.dart';
import 'package:firebase_tutorial/services/auth/authenticate_service.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:firebase_tutorial/views/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  UserFunction userFunction = UserFunction();
  AuthenticationService authenticationService = AuthenticationService();
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
            'Profile',
            style: AppTextStyle.appbarTitle,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                authenticationService.logOut();
                Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
              },
              child: AppIcon.userSetting,
            ),
          ],
        ),
        body: Center(
          child: StreamBuilder(
            stream: users.doc(FirebaseAuth.instance.currentUser!.uid).snapshots(includeMetadataChanges: true),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.hasData)
              {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${snapshot.data['followingID'].length}',
                          ),
                          SizedBox(height: 17.h),
                          Text(
                            'Following',
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 28.w,
                      ),
                      Container(
                        height: 35.h,
                        width: 2.w,
                        color: AppColor.subBorder,
                      ),
                      SizedBox(
                        width: 28.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${snapshot.data['followerID'].length}',
                          ),
                          SizedBox(height: 17.h),
                          Text(
                            'Follower',
                          ),
                        ],
                      )
                    ],
                  ),
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
                  )
                ],
              );
              }
              else if(snapshot.hasError)
              {
                return Text('Error');
              }
              else
              {
                return Text('loading');
              }
            },
          ),
        ),
      ),
    );
  }
}