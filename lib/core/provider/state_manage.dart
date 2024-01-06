import 'dart:io';

import 'package:chat_app/core/constant/colors.dart';
import 'package:chat_app/core/utils/custom_text.dart';
import 'package:chat_app/core/utils/sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../models/chat_model.dart';

class PoviderState with ChangeNotifier {
  bool isSearching = false;
  final List<ModelChat> serachList = [];
  void searching() {
    isSearching = !isSearching;
    notifyListeners();
  }

  void seachingList(List<ModelChat> list, String val) {
    serachList.clear();
    for (var i in list) {
      if (i.name.toString().contains(val.toString()) ||
          i.email.toString().contains(val.toString())) {
        serachList.add(i);
        notifyListeners();
      }
             notifyListeners();

     
    }
  }

 Future<bool> function() async{
if(isSearching){
          searching();
        }
return isSearching; 
 }
  File? images;
   showBottom(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 150.h,
          width: double.infinity,
          child: Column(children: [
            10.h.ph,
            CustomText(
              name: "Select Profile Picture",
              size: 17.sp,
              color: black,
            ),
            24.h.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(45.r),
                  onTap: () async {
                    final picker = await ImagePicker().pickImage(source: ImageSource.camera);
                        if(picker!=null){
                          images=File(picker.path);
                          notifyListeners();
                        }
                  },
                  child: CircleAvatar(
                    radius: 45.r,
                    child: Icon(
                      Icons.camera,
                      size: 65.sp,
                    ),
                  ),
                ),
                35.w.pw,
                InkWell(
                  borderRadius: BorderRadius.circular(45.r),
                  onTap: () async {
                    print("object");
                    final  picker = await ImagePicker().pickImage(source: ImageSource.gallery);
                         if(picker!=null){
                          images=File(picker.path);
                          notifyListeners();
                        }
                  },
                  child: CircleAvatar(
                    radius: 45.r,
                    child: Icon(
                      Icons.picture_in_picture,
                      size: 65.sp,
                    ),
                  ),
                )
              ],
            )
          ]),
        );
      },
    );
  }
}
