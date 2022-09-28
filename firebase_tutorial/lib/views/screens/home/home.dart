import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/export.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    UserFunction userFunction = UserFunction();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Chew', style: AppTextStyle.appbarTitle,),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Logo.png', scale: 2.5,),
              SizedBox(height: 23.h,),
              Text('Welcome, User.........', style: AppTextStyle.appbarTitle,),
              SizedBox(height: 47.h,),
              LoginFuncButton(title: 'JOIN Live', color: AppColor.blueButton, onPressed: (){}),
              SizedBox(height: 14.h,),
              LoginFuncButton(title: 'CREATE Live', color: AppColor.greenButton, onPressed: (){}),
              SizedBox(height: 14.h,),
              LoginFuncButton(title: 'PUBLIC Live', color: AppColor.redButton, onPressed: (){}),
            ],
          ),
        ),
      ),
    );
  }
}