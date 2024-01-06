import 'package:chat_app/core/constant/colors.dart';
import 'package:chat_app/core/utils/sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'custom_text.dart';

class CommonDialog {
  static void showDialogs(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Center(
              child: CircularProgressIndicator(
                color: white,
              ),
            ));
  }

  static hideLoading() {
    Get.back();
  }

  static showCustomDialog({
    required String title,
    required String description,
  }) {
    Get.dialog(Dialog(
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              name: title,
              size: 19.sp,
              color: black,
            ),
            10.h.ph,
            CustomText(
              name: description,
              size: 16.sp,
              color: Colors.black,
            ),
            15.h.ph,
          ],
        ),
      ),
    ));
  }

  static showSuccessFulyySnackbar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: CustomText(
        name: message,
        color: white,
      ),
      backgroundColor: purple,
    ));
  }

  static showFailedSnackbar({required String error}) {
    Get.snackbar("Failed", error,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 900),
        backgroundColor: Colors.purple);
  }

 
}
