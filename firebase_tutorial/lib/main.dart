import 'package:firebase_tutorial/views/screens/home/home.dart';
import 'package:firebase_tutorial/views/screens/login/change_pass.dart';
import 'package:firebase_tutorial/views/screens/login/forget.dart';
import 'package:firebase_tutorial/views/screens/login/login.dart';
import 'package:firebase_tutorial/views/screens/login/signup.dart';
import 'package:firebase_tutorial/views/screens/login/verify.dart';
import 'package:firebase_tutorial/views/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
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
              initialRoute: '/login',
              routes: {
                '/splash': (context) => const SplashScreen(),
                '/login': (context) => const LoginScreen(),
                '/signup' : (context) => const SignUpScreen(),
                '/forgot' :(context) => const ForgotScreen(),
                '/verify' :(context) => const VerifyScreen(),
                '/changepass':(context) => const ChangePassScreen(),
                '/': (context) => const HomeScreen(),
              });
        });
  }
}
