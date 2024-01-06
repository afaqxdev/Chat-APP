// ignore_for_file: avoid_print, body_might_complete_normally_nullable


import 'package:chat_app/core/utils/sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/api_method/api.dart';
import '../../core/constant/images.dart';
import '../../core/utils/Image_Button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          50.h.ph,
          Image.asset(logo),
          170.h.ph,
          ImageButton(
            onTap: () async {
              await Api.checkingUser(context);
            },
            width: 300.w,
            height: 50.h,
          )
        ],
      ),
    );
  }
}
