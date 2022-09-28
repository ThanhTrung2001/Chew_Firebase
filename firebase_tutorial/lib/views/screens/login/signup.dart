import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/services/auth/authenticate_service.dart';
import 'package:firebase_tutorial/services/user/user_service.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:firebase_tutorial/views/components/textfields/textfield_login.dart';
import 'package:firebase_tutorial/views/screens/login/widgets/thirdparty_login_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passController = TextEditingController();
  final passRetypeController = TextEditingController();
  final googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final userFunction = UserFunction();
    final authService = AuthenticationService();
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
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    'assets/icons/Back.png',
                    scale: 3,
                  )),
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
                  height: 34.h,
                ),
                LoginInputTextField(controller: emailController, hint: 'Email'),
                SizedBox(
                  height: 20.h,
                ),
                LoginInputTextField(
                    controller: usernameController, hint: 'Username'),
                SizedBox(
                  height: 20.h,
                ),
                LoginInputTextField(
                    controller: passController, hint: 'Password'),
                SizedBox(
                  height: 20.h,
                ),
                LoginInputTextField(
                    controller: passRetypeController, hint: 'Retype password'),
                SizedBox(
                  height: 11.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 37.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/forgot');
                        },
                        child: const Text(
                          'Forgot?',
                          style: TextStyle(
                              color: Color(0xFF006BE9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                LoginFuncButton(
                    title: 'Signup',
                    color: const Color(0xFFB22759),
                    onPressed: (){
                      authService.emailSignUp(emailController.text,passController.text, usernameController.text);
                    }),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Or',
                  style: TextStyle(
                      fontSize: 14.sp, color: const Color(0xFF818181)),
                ),
                SizedBox(
                  height: 8.h,
                ),
                LoginFuncButton(
                    title: 'Login',
                    color: const Color(0xFF567BC3),
                    onPressed: () {
                      authService.logOut();
                      // Navigator.of(context).pushNamed('/login');
                    }),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Divider(
                      thickness: 1.5.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Copyright@ 2022 by Guineaa',
                      style: TextStyle(
                          fontSize: 18.sp, color: const Color(0xFFA4A4A4)),
                    ),
                    SizedBox(
                      height: 18.h,
                    )
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
