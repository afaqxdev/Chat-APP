import 'package:chat_app/core/constant/images.dart';
import 'package:chat_app/core/utils/custom_text.dart';
import 'package:chat_app/core/utils/sizebox.dart';
import 'package:chat_app/feature/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../sign_in_screen/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      if (FirebaseAuth.instance.currentUser == null) {
        return Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return const SignInScreen();
          },
        ));
      } else {
        return Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return  const HomeScreen();
          },
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(onlyLogo),
          Lottie.asset(load),
          10.h.ph,
          CustomText(
            name: "Made By Xdeveloper ❤️",
            size: 16.sp,
          )
        ],
      ),
    );
  }
}
