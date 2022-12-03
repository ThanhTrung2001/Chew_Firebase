import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/services/token/get_token.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:firebase_tutorial/views/screens/livestream/join_live.dart';
import 'package:firebase_tutorial/views/screens/livestream/live.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
            'Chew',
            style: AppTextStyle.appbarTitle,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Logo.png',
                scale: 2.5,
              ),
              SizedBox(
                height: 23.h,
              ),
              Text(
                'Welcome, User.........',
                style: AppTextStyle.appbarTitle,
              ),
              SizedBox(
                height: 47.h,
              ),
              LoginFuncButton(
                  title: 'JOIN ROOM',
                  color: AppColor.blueButton,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const JoinLiveScreen()));
                  }),
              SizedBox(
                height: 14.h,
              ),
              LoginFuncButton(
                  title: 'CREATE ROOM',
                  color: AppColor.greenButton,
                  onPressed: () {
                    // tokenGenerator.fetchToken(1, 'test', tokenRole);
                  }),
              SizedBox(
                height: 14.h,
              ),
              // LoginFuncButton(
              //     title: 'PUBLIC ROOM',
              //     color: AppColor.redButton,
              //     onPressed: () {
              //       // [Permission.camera].request();
              //       // Navigator.push(
              //       //                       context,
              //       //                       MaterialPageRoute(
              //       //                           builder: (context) =>
              //       //                               const LiveListScreen()));
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
