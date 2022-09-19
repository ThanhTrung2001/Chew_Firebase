import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/config/app_icons.dart';
import 'package:firebase_tutorial/views/components/buttons/button_login.dart';
import 'package:firebase_tutorial/views/components/buttons/button_mini_login.dart';
import 'package:firebase_tutorial/views/components/textfields/textfield_login.dart';
import 'package:firebase_tutorial/views/screens/login/widgets/thirdparty_login_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WaitingScreen extends ConsumerStatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends ConsumerState<WaitingScreen> {
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
            
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Logo
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
            SizedBox(
              height: 30.h,
            ),
            LoadingAnimationWidget.staggeredDotsWave(color: Colors.black, size: 50),
            SizedBox(
              height: 10.h,
            ),
            const Text(
                    'Wait for seconds...',
                    style: TextStyle(fontFamily: 'FreckleFace', fontSize: 18),
                  )

          ],
        ),
      ),
    ));
  }
}
