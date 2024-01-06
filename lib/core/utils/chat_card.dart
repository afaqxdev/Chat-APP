// ignore_for_file: unnecessary_import

import 'package:chat_app/core/constant/images.dart';
import 'package:chat_app/core/models/chat_model.dart';
import 'package:chat_app/core/utils/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    required this.chat,
    super.key});
final ModelChat chat;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12.r)),
      child:  ListTile(
        leading:  ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: FadeInImage( placeholder: const AssetImage(person), // Placeholder image while loading
  image: NetworkImage(chat.image.toString()), // Actual image URL),
        
        ),),
        title: CustomText(name: chat.name.toString()),
        subtitle: CustomText(name: chat.about.toString()),
        trailing: CustomText(name:chat.lastActive.toString()),
      ),
    );
  }
}