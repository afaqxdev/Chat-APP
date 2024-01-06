// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:chat_app/core/constant/colors.dart';
import 'package:chat_app/core/models/chat_model.dart';
import 'package:chat_app/core/provider/state_manage.dart';
import 'package:chat_app/core/utils/custom_text.dart';
import 'package:chat_app/core/utils/loadind_dailog.dart';
import 'package:chat_app/core/utils/sizebox.dart';
import 'package:chat_app/feature/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../core/api_method/api.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({required this.chat, super.key});
  ModelChat chat;
 final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
        final provider = Provider.of<PoviderState>(context, listen: true);

    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: CustomText(name: "Profile"),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: FloatingActionButton.extended(
                backgroundColor: purple,
                icon: const Icon(
                  Icons.logout,
                  color: white,
                ),
                onPressed: () async {
                  CommonDialog.showDialogs(context);
                  await Api.auth.signOut().then((value) async {
                    log("Log out");
                    await GoogleSignIn().signOut().then((value) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return const SignInScreen();
                        },
                      ));
                    });
                  });
                },
                label: CustomText(
                  name: "Logout",
                  color: white,
                )),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                        provider.images==null?  CircleAvatar(
                            radius: 75.r,
                            backgroundImage: NetworkImage(chat.image.toString()),
                          ):Image.file(provider.images!),
                          Positioned(
                              bottom: 0.h,
                              right: 0,
                              child: MaterialButton(
                                onPressed: () {
                                  provider.showBottom(context);
                                },
                                shape: const CircleBorder(),
                                color: purple,
                                child: const Icon(
                                  Icons.edit,
                                  color: white,
                                ),
                              ))
                        ],
                      ),
                      25.h.ph,
                      CustomText(
                        name: chat.email.toString(),
                        color: Colors.grey,
                        size: 18.sp,
                      ),
                      20.h.ph,
                      TextFormField(
                        initialValue: chat.name.toString(),
                      onSaved: (newValue) => Api.profileData.name=newValue??'',
                      validator: (value) => value!=null && value.isNotEmpty ?null : "Rquired this field",
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: "e.g Enter Name",
                          labelText: "Name",
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // contentPadding: EdgeInsets.symmetric(vertical: 12), // Adjust this value as needed
                        ),
                      ),
                      25.h.ph,
                      TextFormField(
                        initialValue: chat.about.toString(),
                         onSaved: (newValue) => Api.profileData.about=newValue??'',
                      validator: (value) => value!=null && value.isNotEmpty ?null : "Rquired this field",
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.info_outline),
                            hintText: "e.g  Enter About",
                            label: const Text("About"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r))),
                      ),
                      30.h.ph,
                      InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () {
                          if(formKey.currentState!.validate()){
                            formKey.currentState!.save();
                            Api.upDateData().then((value) {
                              CommonDialog.showSuccessFulyySnackbar(context: context,message: "SuccessFully Update Prfolie");
                            });


                          }
                        },
                        child: Container(
                            width: 130.w,
                            height: 47.h,
                            decoration: BoxDecoration(
                                color: purple,
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.edit,
                                    color: white,
                                  ),
                                  10.w.pw,
                                  Text(
                                    "Update",
                                    style: TextStyle(color: white, fontSize: 16.sp),
                                  ),
                                ])),
                      ),
                    ]),
              ),
            ),
          )),
    );
  }
}
