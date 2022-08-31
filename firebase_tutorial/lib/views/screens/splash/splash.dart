import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Logo.png',
                    scale: 3,
                  ),
                  SizedBox(
                    height: 8 * size.height / 896,
                  ),
                  Image.asset(
                    'assets/images/CHEW.png',
                    scale: 3,
                  ),
                  const Text(
                    'Connect everyone together!',
                    style: TextStyle(fontFamily: 'FreckleFace', fontSize: 18),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
