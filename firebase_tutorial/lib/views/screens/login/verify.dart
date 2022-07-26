import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:firebase_tutorial/views/components/buttons/button_mini_login.dart';
import 'package:firebase_tutorial/views/components/textfields/textfield_login.dart';
import 'package:firebase_tutorial/views/screens/login/widgets/thirdparty_login_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class VerifyScreen extends ConsumerStatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends ConsumerState<VerifyScreen> {
  final emailController = TextEditingController();
  final googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(top: 17.h, left: 10.w),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/icons/Back.png', scale: 3,)),
          ),
        )),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Logo
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 99.h,
                      ),
                      Image.asset(
                        'assets/images/Logo.png',
                        scale: 3,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Image.asset(
                        'assets/images/CHEW.png',
                        scale: 3,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 95.h,
                ),
                Text('Verify the code in email:', style: TextStyle(fontSize: 18.sp, color: Colors.black),),
                SizedBox(
                  height: 24.h,
                ),
                LoginInputTextField(controller: emailController, hint: 'Code'),
                SizedBox(
                  height: 24.h,
                ),
                LoginFuncButton(title: 'Verify', color: const Color(0xFF285BA7), onPressed: (){
                  Navigator.of(context).pushNamed('/changepass');
                }),
                const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        thickness: 1.5.h,
                      ),
                      SizedBox(height: 20.h,),
                      Text('Copyright@ 2022 by Guineaa', style: TextStyle(fontSize: 18.sp, color: const Color(0xFFA4A4A4)),),
                      SizedBox(height: 18.h,)
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}


