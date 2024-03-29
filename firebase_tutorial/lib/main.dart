import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/views/screens/chat/video_call.dart';
import 'package:firebase_tutorial/views/screens/chat/video_call_main.dart';
import 'package:firebase_tutorial/views/screens/chat/voice_call.dart';
import 'package:firebase_tutorial/views/screens/chat/voice_call_main.dart';
import 'package:firebase_tutorial/views/screens/mainscreen.dart';
import 'package:firebase_tutorial/views/screens/login/change_pass.dart';
import 'package:firebase_tutorial/views/screens/login/forget.dart';
import 'package:firebase_tutorial/views/screens/login/login.dart';
import 'package:firebase_tutorial/views/screens/login/signup.dart';
import 'package:firebase_tutorial/views/screens/login/verify.dart';
import 'package:firebase_tutorial/views/screens/login/waiting.dart';
import 'package:firebase_tutorial/views/screens/post/current_user/post.dart';
import 'package:firebase_tutorial/views/screens/profile/profile.dart';
import 'package:firebase_tutorial/views/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
//call
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:toast/toast.dart';

void main() async {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.top]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Chew - Flutter',
              theme:
                  ThemeData(primarySwatch: Colors.blue, fontFamily: 'FiraCode'),
              // home: const SplashScreen(),
              initialRoute:
                  FirebaseAuth.instance.currentUser == null ? '/login' : '/',
              routes: {
                '/splash': (context) => const SplashScreen(),
                '/login': (context) => const LoginScreen(),
                '/signup': (context) => const SignUpScreen(),
                '/forgot': (context) => const ForgotScreen(),
                '/verify': (context) => const VerifyScreen(),
                '/changepass': (context) => const ChangePassScreen(),
                '/waiting': (context) => const WaitingScreen(),
                '/': (context) => const MainScreen(),
                '/home': (context) => const PostScreen(),
                '/profile': (context) => const ProfileScreen(),
                '/voice_test': (context) => const VoiceCallingScreen(),
                '/voice': (context) => const VoiceCallMainScreen(),
                '/video_test': (context) => const VideoCallingScreen(),
                '/video': (context) => const VideoCallMainScreen(),
              });
        });
  }
}
