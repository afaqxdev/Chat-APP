// ignore_for_file: file_names, must_be_immutable

import 'package:chat_app/core/constant/colors.dart';
import 'package:chat_app/core/constant/images.dart';
import 'package:chat_app/core/utils/sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageButton extends StatelessWidget {
   ImageButton({this.width,this.height,required this.onTap,super.key});
final double? width;
final double ?height;
void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r)
      ,
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: black,borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(google,scale: 2.5,),
          10.w.pw,
          RichText(text: TextSpan(children: [
            TextSpan(text:'Sign In with',
            style: TextStyle(color: white,fontSize:16.sp)),
       TextSpan(text:'\tGoogle',
            style: TextStyle(color: purple,fontWeight: FontWeight.bold,fontSize:17.sp)),
          ]),
          ),
          // CustomText(name: "Sign In with Google",color:white ,
          // size: 18.sp,)
        ],),
      ),
    );
  }
}